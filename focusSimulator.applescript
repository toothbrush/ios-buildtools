# This usually works to bring the iOS Sim to front. 
# Should be called after a successful build.
tell application "System Events"
	using terms from application "System Events"
		tell application "iPhone Simulator"
			activate
		end tell
	end using terms from
end tell
