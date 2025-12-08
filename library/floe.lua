-- Etherealwinds Harp 2: Community Edition is licensed under a Creative Commons Attribution 4.0 International License.
-- https://versilian-studios.com/etherealwinds-harp/
--
-- This file is a direct translation of Harp_Normal.sfz into Floe's Lua format.
-- This file is also licensed under a Creative Commons Attribution 4.0 International License.
-- https://creativecommons.org/licenses/by/4.0/deed.en
-- Copyright Sam Windell 2025

floe.set_required_floe_version("0.12.0")

local library = floe.new_library({
    name = "Celtic Harp",
    tagline = "Multisampled Celtic Harp",
    author = "Floe Ports",
    description =
    "High-quality multisampled Celtic harp. It's a slightly modified version of Versilian Studios - Etherealwinds Harp 2: Community Edition. This port was made by the Floe team.",
    library_url = "https://github.com/Floe-Project/Harp",
    author_url = "https://versilian-studios.com/etherealwinds-harp/",
    background_image_path = "Images/Harpe Celtique Telenn Gentañ - Alan Stivell - 04.jpg",
    icon_image_path = "Images/icon.png",
    minor_version = 2,
})

floe.set_attribution_requirement("Samples", {
    title = "Etherealwinds Harp 2: Community Edition",
    license_name = "CC-BY-4.0",
    license_url = "https://creativecommons.org/licenses/by/4.0/",
    attributed_to = "Versilian Studios",
    attribution_url = "https://versilian-studios.com/etherealwinds-harp/",
})

local instrument = floe.new_instrument(library, {
    name = "Celtic Harp",
    description = "High-quality multisampled Celtic harp.",
    tags = { "acoustic", "plucked strings", "solo", "orchestral", "cinematic", "folk" },
})

local sample_info = dofile("Lua/sample-info.lua")

floe.add_named_key_range(instrument, {
    name = "Natural Range",
    key_range = { 36, 93 },
})

for rr_index, group in ipairs(sample_info) do
    for _, region_info in ipairs(group) do
        floe.add_region(instrument, {
            path = "Samples/" .. region_info.sample,
            root_key = region_info.pitch_keycenter,
            trigger_criteria = {
                key_range = { region_info.lokey, region_info.hikey + 1 },
                velocity_range = floe.midi_range_to_hundred_range({ region_info.lovel, region_info.hivel }),
                round_robin_index = rr_index - 1,
            },
        })
    end
end

return library
