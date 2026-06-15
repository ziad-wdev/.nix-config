local image = "{{image}}"

<* for name, value in colors *>
local {{name}} = "rgb({{value.default.hex_stripped}})"
<* endfor *>

hl.config({
  general = {
    col = {
      active_border = primary,
      inactive_border = background,
    },
  },
  group = {
    col = {
      border_active = primary,
      border_inactive = background,
      border_locked_active = secondary,
    },
    groupbar = {
      col = {
        active = primary,
        inactive = background,
      },
      text_color = on_primary,
    },
  },
  misc = {
    background_color = background,
  }
})
