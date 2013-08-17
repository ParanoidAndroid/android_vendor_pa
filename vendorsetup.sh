for combo in $(find vendor/pa -name "pa_*.mk" -exec basename '{}' \; | cut -f1 -d.); do
	echo "Adding vendor combo: [${combo}-userdebug]"
	add_lunch_combo ${combo}-userdebug
done
