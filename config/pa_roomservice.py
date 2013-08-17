#!/usr/bin/env python
import os
import sys
import urllib2
import json
import re
from xml.etree import ElementTree

syncable_repos = []
fetch_list = []

def exists_in_tree(lm, repository):
    for child in lm.getchildren():
        if child.attrib['name'].endswith(repository):
            return True
    return False

# in-place prettyprint formatter
def indent(elem, level=0):
    i = "\n" + level*"  "
    if len(elem):
        if not elem.text or not elem.text.strip():
            elem.text = i + "  "
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
        for elem in elem:
            indent(elem, level+1)
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
    else:
        if level and (not elem.tail or not elem.tail.strip()):
            elem.tail = i

def is_in_manifest(projectname, type=""):
    try:
        lm = ElementTree.parse(".repo/local_manifests/roomservice.xml")
        lm = lm.getroot()
    except:
        lm = ElementTree.Element("manifest")

    if type == "remove":
        for localpath in lm.findall("remove-project"):
            if localpath.get("name")[localpath.get("name").find('/')+1:] == projectname:
                return 1
    else:
        for localpath in lm.findall("project"):
            if localpath.get("name") == projectname:
                return 1

    return None

def add_projects(repositories):
    if not os.path.exists(".repo/local_manifests/"):
        os.makedirs(".repo/local_manifests/")

    try:
        lm = ElementTree.parse(".repo/local_manifests/roomservice.xml")
        lm = lm.getroot()
    except:
        lm = ElementTree.Element("manifest")

    for repository in repositories:
        repo_name = repository['repository']
        repo_target = repository['target_path']

        try:
            repo_remote = repository['remote']
        except:
            repo_remote = "github"

        try:
            repo_revision = repository['revision']
        except:
            repo_revision = "jb43"

        try:
            repo_account = repository['account']
            repo_full = repo_account + '/' + repo_name
        except:
            repo_full = repo_name

        if exists_in_tree(lm, repo_full):
            if is_in_manifest(repo_name, "remove"):
                print '[%s] exists but as remove-project' % repo_full
            else:
                print '[%s] already exists' % repo_full
                continue

        print 'Adding project: [%s] -> [%s]' % (repo_full, repo_target)
        project = ElementTree.Element("project", attrib = { "path": repo_target,
            "remote": repo_remote, "name": repo_full, "revision": repo_revision })

        if 'branch' in repository:
            project.set('revision',repository['branch'])

        lm.append(project)

    indent(lm, 0)
    raw_xml = ElementTree.tostring(lm)
    raw_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' + raw_xml

    f = open('.repo/local_manifests/roomservice.xml', 'w')
    f.write(raw_xml)
    f.close()

def remove_projects(repositories):
    if not os.path.exists(".repo/local_manifests/"):
        os.makedirs(".repo/local_manifests/")

    try:
        lm = ElementTree.parse(".repo/local_manifests/roomservice.xml")
        lm = lm.getroot()
    except:
        lm = ElementTree.Element("manifest")

    for repository in repositories:
        repo_name = repository['name']
        if exists_in_tree(lm, repo_name):
            print '[%s] already exists' % repo_name
            continue

        print 'Adding remove-project: [%s]' % (repo_name)
        project = ElementTree.Element("remove-project", attrib = { "name": repo_name })

        if 'branch' in repository:
            project.set('revision',repository['branch'])

        lm.insert(0,project)

    indent(lm, 0)
    raw_xml = ElementTree.tostring(lm)
    raw_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' + raw_xml

    f = open('.repo/local_manifests/roomservice.xml', 'w')
    f.write(raw_xml)
    f.close()

def process_projects(manifest):
    print 'Looking for remove/add projects entries from [%s]' % manifest

    if os.path.exists(manifest):
        projects_file = open(manifest, 'r')
        projects = json.loads(projects_file.read())

        # Removing projects
        fetch_list = []
        for project in projects[1]:
            repo_name = project['name']
            print '  Check for [%s] in local_manifest' % repo_name
            if not is_in_manifest(repo_name):
                fetch_list.append(project)
            else:
                print '  [%s] already in local_manifest' % repo_name

        if len(fetch_list) > 0:
            print 'Adding remove-project entries to local_manifest'
            remove_projects(fetch_list)

        # Adding projects
        fetch_list = []
        for project in projects[0]:
            try:
                repo_account = project['account']
                repo_full = repo_account + '/' + project['repository']
            except:
                repo_full = project['repository']

            print '  Check for [%s] in local_manifest' % repo_full
            if not is_in_manifest(repo_full):
                print 'Appending [%s] to fetch_list and [%s] to syncable_repos' % (repo_full, project['target_path'])
                fetch_list.append(project)
                syncable_repos.append(project['target_path'])
            else:
                print '  [%s] already in local_manifest' % repo_full

        if len(fetch_list) > 0:
            print 'Adding projects to local_manifest'
            add_projects(fetch_list)

        projects_file.close()
    else:
        print 'Projects definition file [%s] not found, skipping.' % manifest

for target in sys.argv[1:]:
    process_projects('vendor/pa/' + target + ".manifest")
    process_projects('vendor/pa/' + target + "_extra.manifest")

if len(syncable_repos) > 0:
    print 'Syncing projects'
    os.system('repo sync %s' % ' '.join(syncable_repos))
