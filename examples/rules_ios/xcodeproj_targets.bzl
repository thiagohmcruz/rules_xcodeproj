"""Exposes targets used by `xcodeproj` to allow use in fixture tests."""

load(
    "@rules_xcodeproj//xcodeproj:defs.bzl",
    "top_level_targets",
    "xcode_schemes",
)

XCODEPROJ_TARGETS = [
    "//iOSApp/Source/CoreUtilsObjC:CoreUtilsObjC"
]

IOS_BUNDLE_ID = "rules-xcodeproj.example"
TEAMID = "V82V4GQZXM"

SCHEME_AUTOGENERATION_MODE = "all"

def get_xcode_schemes():
    return []
