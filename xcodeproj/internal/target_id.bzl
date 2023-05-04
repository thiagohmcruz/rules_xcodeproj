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

def write_target_ids_list(*, actions, name, target_dtos, multiple_labels):
    """Writes the list of target IDs for a set of `xcode_target`s to a file.

    Args:
        actions: `ctx.actions`.
        name: `ctx.attr.name`.
        target_dtos: A `dict` with target IDs as keys.
        multiple_labels: foo

    Returns:
        The `File` that was written.
    """
    output = actions.declare_file(
        "{}_target_ids".format(name),
    )

    args = actions.args()
    args.set_param_file_format("multiline")
    foo_keys = []
    for tk in target_dtos.keys():
        found = False
        tk_label = tk.split(" ")[0]
        for k, ids in multiple_labels.items():
            for id in ids:
                if id == Label(tk_label) and k not in foo_keys:
                    found = True
                    foo_keys.append(k)
                    break
        if not found:
            foo_keys.append(tk)

    args.add_all(sorted(foo_keys))

    actions.write(
        output,
        args,
    )

    return output
