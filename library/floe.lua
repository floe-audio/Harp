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
    minor_version = 3,
})

floe.set_attribution_requirement("Samples", {
    title = "Etherealwinds Harp 2: Community Edition",
    license_name = "CC-BY-4.0",
    license_url = "https://creativecommons.org/licenses/by/4.0/",
    attributed_to = "Versilian Studios",
    attribution_url = "https://versilian-studios.com/etherealwinds-harp/",
})

do
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
end

local fx_sample_info = dofile("Lua/phrase_fx_info.lua")
local fx_peak_db = -3.0

for _, fx in ipairs({
    { file = "EWHarp_FX7.flac",   name = "Glissando Ascending 1",  dissonant = false },
    { file = "EWHarp_FX28.flac",  name = "Glissando Ascending 2",  dissonant = false },
    { file = "EWHarp_FX122.flac", name = "Glissando Ascending 3",  dissonant = false },
    { file = "EWHarp_FX110.flac", name = "Glissando Ascending 4",  dissonant = true },
    { file = "EWHarp_FX8.flac",   name = "Glissando Descending 1", dissonant = false },
    { file = "EWHarp_FX31.flac",  name = "Glissando Descending 2", dissonant = false },
    { file = "EWHarp_FX123.flac", name = "Glissando Descending 3", dissonant = false },
}) do
    local tags = { "acoustic", "plucked strings", "solo", "oneshot", "multi-pitched", "sound fx", "orchestral",
        "cinematic", "folk", "dreamy" }
    if fx.dissonant then
        table.insert(tags, "dissonant")
        table.insert(tags, "eerie")
    end

    local instrument = floe.new_instrument(library, {
        name = fx.name,
        description = fx.name,
        folder = "FX",
        tags = tags,
    })

    floe.add_region(instrument, {
        path = "Samples/Vocal Phrases & FX/" .. fx.file,
        root_key = 60,
        trigger_criteria = {
            key_range = { 0, 128 },
        },
        audio_properties = {
            gain_db = -fx_sample_info[fx.file].peak_db - -fx_peak_db,
        },
    })
end

do
    local samples = {
        { file = "JordiVox_Phrases_C4_rr12.flac", name = "Vocal Phrase C 1" },
        { file = "JordiVox_Phrases_C4_rr18.flac", name = "Vocal Phrase C 2" },
        { file = "JordiVox_Phrases_C4_rr3.flac",  name = "Vocal Phrase C 3" },
        { file = "JordiVox_Phrases_C4_rr4.flac",  name = "Vocal Phrase C 4" },
        { file = "JordiVox_Phrases_C4_rr8.flac",  name = "Vocal Phrase C 5" },
        { file = "JordiVox_Phrases_D4_rr11.flac", name = "Vocal Phrase D 1" },
        { file = "JordiVox_Phrases_D4_rr3.flac",  name = "Vocal Phrase D 2" },
        { file = "JordiVox_Phrases_D4_rr4.flac",  name = "Vocal Phrase D 3" },
        { file = "JordiVox_Phrases_D4_rr7.flac",  name = "Vocal Phrase D 5" },
        { file = "JordiVox_Phrases_F4_rr13.flac", name = "Vocal Phrase F 1" },
        { file = "JordiVox_Phrases_F4_rr16.flac", name = "Vocal Phrase F 2" },
        { file = "JordiVox_Phrases_F4_rr7.flac",  name = "Vocal Phrase F 3" },
        { file = "JordiVox_Phrases_G3_rr12.flac", name = "Vocal Phrase G 1" },
        { file = "JordiVox_Phrases_G3_rr15.flac", name = "Vocal Phrase G 2" },
        { file = "JordiVox_Phrases_G3_rr19.flac", name = "Vocal Phrase G 3" },
        { file = "JordiVox_Phrases_G3_rr5.flac",  name = "Vocal Phrase G 4" },
    }

    do
        local instrument = floe.new_instrument(library, {
            name = "Vox Phrase Multi",
            description =
            "A collection of vocal phrase one-shots by \"etherealwinds\" mapped to individual keys near middle C.",
            folder = "Vocal Phrases",
            tags = { "vocal", "solo", "oneshot", "multi-pitched", "breathy", "ethereal", "dreamy", "peaceful", "cinematic", "ambient" },
        })


        local start_key = 60

        floe.add_named_key_range(instrument, {
            name = "Phrase Keys",
            key_range = { start_key, start_key + #samples - 1 },
        })

        for index, sample in ipairs(samples) do
            local root_key = start_key + index - 1
            floe.add_region(instrument, {
                path = "Samples/Vocal Phrases & FX/" .. sample.file,
                root_key = root_key,
                trigger_criteria = {
                    key_range = { root_key, root_key + 1 },
                },
                audio_properties = {
                    gain_db = -fx_sample_info[sample.file].peak_db - -fx_peak_db,
                },
            })
        end
    end

    for _, sample in ipairs(samples) do
        local instrument = floe.new_instrument(library, {
            name = sample.name,
            description = "A vocal phrase one-shot by \"etherealwinds\".",
            folder = "Vocal Phrases",
            tags = { "vocal", "solo", "oneshot", "multi-pitched", "breathy", "ethereal", "dreamy", "peaceful", "cinematic", "ambient" },
        })

        floe.add_region(instrument, {
            path = "Samples/Vocal Phrases & FX/" .. sample.file,
            root_key = 60,
            trigger_criteria = {
                key_range = { 0, 128 },
            },
            audio_properties = {
                gain_db = -fx_sample_info[sample.file].peak_db - -fx_peak_db,
            },
        })
    end
end


return library
