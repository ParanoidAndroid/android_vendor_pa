for combo in $(find vendor/pa -name "pa_*.mk" -exec basename '{}' \; | cut -f1 -d.); do
	add_lunch_combo ${combo}-userdebug
done
