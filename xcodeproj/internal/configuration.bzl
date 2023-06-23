"""Functions for calculating configuration."""

def calculate_configuration(*, bin_dir_path, ctx = None):
    """Generates a configuration identifier for a target.

    `ConfiguredTarget.getConfigurationKey()` isn't exposed to Starlark, so we
    are using the output directory as a proxy.

    Args:
        bin_dir_path: `ctx.bin_dir.path`.
        ctx: The aspect context.

    Returns:
        A string that uniquely identifies the configuration of a target.
    """
    path_components = bin_dir_path.split("/")

    if len(path_components) > 2:
        configuration = path_components[1]
        if ctx \
        and "applebin_ios-" in configuration \
        and len(configuration) > 1 \
        and ( ( ctx.rule.kind == "objc_library" and ctx.rule.attr.name.endswith("_objc") ) or ( ctx.rule.kind == "swift_library" and ctx.rule.attr.name.endswith("_swift") ) ) \
        or ( ctx and ctx.rule.kind == "apple_framework_packaging" ):
            configuration_components = configuration.split("applebin_ios")
            configuration = "applebin_ios" + configuration_components[1]

        return configuration
    return ""
