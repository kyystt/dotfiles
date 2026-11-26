return {
    "sphamba/smear-cursor.nvim",

    opts = {
        -- Smear cursor when switching buffers or windows.
        smear_between_buffers = true,

        -- Smear cursor when moving within line or to neighbor lines.
        -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
        smear_between_neighbor_lines = true,

        -- Draw the smear in buffer space instead of screen space when scrolling
        scroll_buffer_space = true,

        -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
        -- Smears and particles will look a lot less blocky.
        legacy_computing_symbols_support = true,

        -- Smear cursor in insert mode.
        -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
        smear_insert_mode = true,

        -- normal mode
        stiffness = 0.5,
        trailing_stiffness = 0.35,
        trailing_exponent = 3,
        distance_stop_animating = 0.5,

        -- insert mode
        stiffness_insert_mode = 0.25,
        trailing_stiffness_insert_mode = 0.25,
        damping_insert_mode = 0.9,
        trailing_exponent_insert_mode = 1,
        distance_stop_animating_vertical_bar = 0.1,


        -- particles_enabled = true,
        -- particle_max_num = 200,
        -- never_draw_over_target = true,
        time_interval = 7,
    },
}
