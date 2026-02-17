Gemini_HeroMultiAlignedPrompt(imageCount := "") {
    if (imageCount = "") {
        ib := InputBox("How many attached images should be referenced?", "Gemini Prompt", "w340 h140", "3")
        if (ib.Result != "OK") {
            return false
        }

        imageCount := Trim(ib.Value)
    }

    if (!RegExMatch(imageCount, "^\d+$")) {
        MsgBox("Please enter a whole number (for example: 3).", "Gemini Prompt", "Icon!")
        return false
    }

    template := "
(
Use the NUMBER attached images as the exact artworks displayed in the frames.

Each artwork must remain completely unchanged:
- No color changes
- No cropping
- No stretching
- No warping
- No perspective distortion
- No style reinterpretation

Preserve each artwork's original aspect ratio exactly.
Each frame opening must match its artwork's exact proportions.
Do not adapt any artwork to a different ratio.

Create a photorealistic product mockup for an Etsy digital wall art listing featuring a coordinated set of three framed prints.

Scene:
A clean, minimal interior wall with NUMBER framed art prints displayed side-by-side in a horizontal row.

Layout:
- All NUMBER frames must be identical in size and style
- Equal spacing between each frame
- Perfect horizontal alignment
- All frames centered as a unified set on the wall
- The artworks must have equal visual size within their frames

Frame:
- Thin modern frame (something that compliments the art)
- Subtle realistic depth
- Optional thin white mat sized proportionally
- Matte finish, no glare

Placement:
- Artwork centered perfectly in each frame
- Frames aligned flat against the wall
- Camera angle perfectly straight-on
- All artwork surfaces must remain perfectly rectangular
- Vertical and horizontal edges must remain parallel
- No tilting or perspective shift

Lighting:
- Soft natural daylight
- Gentle realistic shadows beneath frames
- Even lighting across all three prints
- No reflections obscuring any artwork

Composition:
- Final output image is square (1:1)
- The full set of three framed artworks remains fully visible
- No cropping of any frame
- The set should feel balanced and cohesive

Style:
- Ultra realistic
- Clean professional product photography
- No text, no logos, no watermarks, no people
)"

    promptText := StrReplace(template, "NUMBER", imageCount)

    clipSaved := ClipboardAll()
    try {
        A_Clipboard := promptText
        if (!ClipWait(1)) {
            MsgBox("Could not set clipboard for paste.", "Gemini Prompt", "Icon!")
            return false
        }

        Send("^v")
        Sleep(100)
    } finally {
        A_Clipboard := clipSaved
    }

    return true
}
