"""Functions dealing with Target IDs."""

def get_id(*, label, configuration):
    """Generates a unique identifier for a target.

    Args:
        label: The `Label` of the `Target`.
        configuration: The value returned from `calculate_configuration`.

    Returns:
        An opaque string that uniquely identifies the target.
    """
    return "{} {}".format(label, configuration)

def _longest_common_prefix(strs):
    if not strs:
        return ""
    shortest_str = strs[0]
    for s in strs:
        if len(s) < len(shortest_str):
            shortest_str = s
    index = 0
    for char in shortest_str.elems():
        for other in strs:
            if other[index] != char:
                return shortest_str[:index]
        index += 1
    return shortest_str

def get_shared_label(*, id, labels):
    """Foo

    Args:
        id: foo
        labels: foo

    Returns:
        Foo
    """
    test_bundle_internal_indentifier = ".__internal__.__test_bundle"
    id_label = id.split(" ")[0]
    if test_bundle_internal_indentifier in id:
        if "@" not in id_label:
            id_label = "@{}".format(id_label)
        return id_label.replace(test_bundle_internal_indentifier, "")

    longest_common_prefix = _longest_common_prefix([id_label] + ["@%s" % label for label in labels])
    if "@" not in "%s" % longest_common_prefix:
        longest_common_prefix = "@{}".format(longest_common_prefix)
    return longest_common_prefix

def write_target_ids_list(*, actions, name, target_dtos):
    """Writes the list of target IDs for a set of `xcode_target`s to a file.

    Args:
        actions: `ctx.actions`.
        name: `ctx.attr.name`.
        target_dtos: A `dict` with target IDs as keys.

    Returns:
        The `File` that was written.
    """
    output = actions.declare_file(
        "{}_target_ids".format(name),
    )

    args = actions.args()
    args.set_param_file_format("multiline")
    args.add_all(sorted(target_dtos.keys()))

    actions.write(
        output,
        args,
    )

    return output
