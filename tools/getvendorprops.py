#!/usr/bin/env python
import os
import sys
import urllib2
import json
import re
from xml.etree import ElementTree

product = sys.argv[1];

device = product[product.index("_") + 1:]

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

def is_in_manifest(projectname):
    try:
        lm = ElementTree.parse(".repo/local_manifests/roomservice.xml")
        lm = lm.getroot()
    except:
        lm = ElementTree.Element("manifest")

    for localpath in lm.findall("project"):
        if localpath.get("name") == projectname:
            return 1

    return None

def add_to_manifest(repositories):
    if not os.path.exists(".repo/local_manifests/"):
        os.makedirs(".repo/local_manifests/")

    try:
        lm = ElementTree.parse(".repo/local_manifests/roomservice.xml")
        lm = lm.getroot()
    except:
        lm = ElementTree.Element("manifest")

    for repository in repositories:
        try:
            repo_remote = repository['remote']
        except:
            repo_remote = "github"
        repo_account = repository['account']
        repo_name = repository['repository']
        repo_target = repository['target_path']
        try:
            repo_revision = repository['revision']
        except:
            repo_revision = "jellybean"
        repo_full = repo_account + '/' + repo_name
        if exists_in_tree(lm, repo_full):
            print '%s already exists' % repo_full
            continue

        print 'Adding proprietary: %s -> %s' % (repo_full, repo_target)
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

def fetch_proprietaries(device):
    print 'Looking for vendor proprietaries'
    proprietaries_path = 'vendor/pa/vendorprops/' + device + '.proprietaries'

    syncable_repos = []

    if os.path.exists(proprietaries_path):
        proprietaries_file = open(proprietaries_path, 'r')
        proprietaries = json.loads(proprietaries_file.read())
        fetch_list = []

        for proprietary in proprietaries:
            repo_full = proprietary['account'] + "/" + proprietary['repository']
            print '  Check for %s in local_manifest' % repo_full
            if not is_in_manifest(repo_full):
                fetch_list.append(proprietary)
                syncable_repos.append(proprietary['target_path'])
            else:
                print '  %s already in local_manifest' % repo_full

        proprietaries_file.close()

        if len(fetch_list) > 0:
            print 'Adding proprietaries to local_manifest'
            add_to_manifest(fetch_list)
    else:
        print 'proprietaries definition file not found, bailing out.'

    if len(syncable_repos) > 0:
        print 'Syncing proprietaries'
        os.system('repo sync %s' % ' '.join(syncable_repos))


fetch_proprietaries(device)
