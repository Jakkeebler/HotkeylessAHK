; Multi Piece - Aligned ---------------------------------
; Hero - Multi Piece - Aligned
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

Create a photorealistic product mockup for an Etsy digital wall art listing featuring a coordinated set of NUMBER framed prints.

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
- Even lighting across all NUMBER prints
- No reflections obscuring any artwork

Composition:
- Final output image is square (1:1)
- The full set of NUMBER framed artworks remains fully visible
- No cropping of any frame
- The set should feel balanced and cohesive

Style:
- Ultra realistic
- Clean professional product photography
- No text, no logos, no watermarks, no people

If more than NUMBER frames appear, or any frame is tilted, resized, duplicated, or distorted, regenerate the image.
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

; Room - Multi Piece - Aligned
Gemini_RoomMultiAlignedPrompt(imageCount := "") {
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

Exactly NUMBER framed artworks must appear.
- Do not add extra frames.
- Do not duplicate any artwork.
- Each artwork must appear once and only once.

Each artwork must remain completely unchanged:
- No color changes
- No cropping
- No stretching
- No warping
- No perspective distortion
- No style reinterpretation

Preserve each artwork’s original aspect ratio exactly.
Each frame opening must match its artwork’s exact proportions.

Create a photorealistic lifestyle mockup in a calm, cozy interior bedroom or personal room setting.

Environment:
- Soft neutral wall tones (warm beige, cream, soft taupe)
- Minimal decor such as a neatly styled bed, nightstand, linen bedding, or subtle plant
- Decor must not block or overlap the artwork
- The artwork set is the clear focal point
- Clean, peaceful, dreamy atmosphere

Layout:
- Exactly NUMBER identical frames
- All frames same size and style
- Perfect horizontal alignment
- Even spacing between frames
- All frames hung at the same height
- Frames remain perfectly straight, no tilting or rotation

The NUMBER pieces should read as a cohesive set

Frame:
- Thin modern frame (something that compliments the art)
- Subtle realistic depth
- Optional thin white mat sized proportionally
- Matte finish, no glare

Placement:
- Frames aligned flat against the wall
- Camera straight-on or very slightly angled
- All artwork surfaces must remain perfectly rectangular
- Vertical and horizontal edges must remain parallel
- No perspective distortion
- No cropping of frames

Lighting:
- Soft natural daylight entering from one side
- Warm, cozy, inviting atmosphere
- Gentle realistic shadows beneath frames
- Even lighting across all NUMBER artworks
- No glare or reflections obscuring artwork

Composition:
- Final output square (1:1)
- All NUMBER frames fully visible
- Artwork unobstructed
- Balanced, intentional lifestyle composition

Style:
- Ultra realistic lifestyle photography
- Soft depth of field in background only (not on artwork)
- No text, no people, no logos, no watermarks

If more than NUMBER frames appear, or any frame is tilted, resized, duplicated, or distorted, regenerate the image.
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

; Office - Multi Piece - Aligned
Gemini_OfficeMultiAlignedPrompt(imageCount := "") {
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

Exactly NUMBER framed artworks must be shown.
Do not add extra frames.
Do not duplicate any artwork.
Each artwork must appear once and only once.

Each artwork must remain completely unchanged:
- No color changes
- No cropping
- No stretching
- No warping
- No perspective distortion
- No style reinterpretation

Preserve each artwork’s original aspect ratio exactly.
Each frame opening must match its artwork’s exact proportions.

Create a photorealistic lifestyle mockup in a modern office or creative workspace featuring the NUMBER artworks aligned horizontally.

Environment:
- Modern home office or creative workspace
- Desk present beneath or near the artwork
- Clean professional decor (minimal plant, lamp, notebook, monitor)
- Decor must not overlap or block the artwork
- Neutral wall tones

Layout:
- Exactly NUMBER identical frames
- All frames same size and style
- Perfect horizontal alignment
- Even spacing between frames
- All frames hung at the same height
- Frames must remain perfectly straight (no tilting or rotation)

Frame:
- Thin modern frame (something that compliments the art)
- Matte finish
- Subtle realistic depth

Placement:
- Artwork positioned naturally above desk or workspace
- Frames aligned flat against the wall
- Camera straight-on or very slightly angled
- All artwork surfaces perfectly rectangular
- Vertical and horizontal edges parallel
- No perspective distortion

Lighting:
- Natural daylight or soft ambient office lighting
- Even lighting across all NUMBER artworks
- No glare or reflections

Composition:
- Final image square (1:1)
- All NUMBER frames fully visible
- Workspace visible but secondary to artwork
- Balanced professional composition

Style:
- Ultra realistic professional interior photography
- No text
- No people
- No logos
- No watermarks

If more than NUMBER frames appear, or any frame is tilted, resized, duplicated, or distorted, regenerate the image.
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

; Living - Multi Piece - Aligned
Gemini_LivingMultiAlignedPrompt(imageCount := "") {
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

Exactly NUMBER framed artworks must be shown.
Do not add extra frames.
Do not duplicate any artwork.
Each artwork must appear once and only once.

Each artwork must remain completely unchanged:
- No color changes
- No cropping
- No stretching
- No warping
- No perspective distortion
- No style reinterpretation

Preserve each artwork’s original aspect ratio exactly.
Each frame opening must match its artwork’s exact proportions.

Create a photorealistic lifestyle mockup in a modern living space featuring the NUMBER artworks aligned horizontally.

Environment:
- Modern living room or lounge
- Sofa positioned beneath or near the artwork
- Subtle decor elements (throw pillows, coffee table, minimal plant)
- Neutral warm tones
- Decor must not block or overlap the artwork
- Artwork set is the focal point

Layout:
- Exactly NUMBER identical frames
- All frames same size and style
- Perfect horizontal alignment
- Even spacing between frames
- All frames hung at the same height
- Frames perfectly straight (no tilting or rotation)
- No resizing differences between frames

Frame:
- Modern thin frame (something that compliments the art)
- Realistic depth and subtle shadow
- Matte finish, no glare

Placement:
- Frames aligned flat against the wall
- Camera straight-on or very slightly angled
- All artwork surfaces perfectly rectangular
- Vertical and horizontal edges parallel
- No perspective distortion

Lighting:
- Soft natural light entering from one side
- Warm, inviting atmosphere
- Even lighting across all NUMBER artworks
- No glare or reflections

Composition:
- Final image square (1:1)
- All NUMBER frames fully visible
- Living space visible but secondary to artwork
- Balanced professional lifestyle composition

Style:
- Ultra realistic interior photography
- No text
- No people
- No logos
- No watermarks

If more than NUMBER frames appear, or any frame is resized, tilted, duplicated, or distorted, regenerate the image.
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

; Statement - Multi Piece - Aligned
Gemini_StatementMultiAlignedPrompt(imageCount := "") {
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

Exactly NUMBER framed artworks must be shown.
Do not add extra frames.
Do not duplicate any artwork.
Each artwork must appear once and only once.

Each artwork must remain completely unchanged:
- No color changes
- No cropping
- No stretching
- No warping
- No perspective distortion
- No style reinterpretation

Preserve each artwork’s original aspect ratio exactly.
Each frame opening must match its artwork’s exact proportions.

Create a dramatic, high-impact statement-room mockup featuring the NUMBER artworks aligned horizontally.

Inspiration:
- Take inspiration from the artwork’s dreamy pastel tones and soft glow
- The environment should complement the mood without overpowering the artwork
- The artwork must remain geometrically accurate

Environment:
- Loft, gallery-style room, or elevated creative studio
- Expressive atmosphere (textured wall, subtle architectural interest)
- Background elements must not overlap or block the artwork
- No additional wall art

Layout:
- Exactly NUMBER identical frames
- All frames same size and style
- Perfect horizontal alignment
- Even spacing between frames
- All frames hung at the same height
- Frames perfectly straight (no tilting or rotation)
- No resizing differences

Frame:
- Modern thin frame (something that compliments the art)
- Realistic depth and subtle shadow
- Matte finish, no glare

Placement:
- Frames prominently centered on the wall
- Camera straight-on or very slightly angled
- All artwork surfaces perfectly rectangular
- Vertical and horizontal edges parallel
- No lens distortion affecting the artwork plane

Lighting:
- Cinematic room lighting
- Soft directional light creating subtle wall shadows
- Artwork evenly lit and fully visible
- No glare or reflection on artwork surface

Composition:
- Square (1:1) output
- All NUMBER frames fully visible
- Artwork set is the clear focal point
- Dramatic but balanced editorial composition

Style:
- Ultra realistic editorial interior photography
- No text
- No people
- No logos
- No watermarks

If more than NUMBER frames appear, or any frame is resized, tilted, duplicated, or distorted, regenerate the image.

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

; Multi Piece - Staggered ------------------------------
; Hero - Multi Piece - Staggered
Gemini_HeroMultiStaggeredPrompt(imageCount := "") {
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

Exactly NUMBER framed artworks must be shown.
Do not add any additional frames.
Do not duplicate any artwork.
Do not create a fourth frame for balance.

Each artwork must remain completely unchanged:
- No color changes
- No cropping
- No stretching
- No warping
- No perspective distortion
- No style reinterpretation

Preserve each artwork’s original aspect ratio exactly.
Each frame opening must match its artwork’s exact proportions.

Create a photorealistic product mockup for an Etsy digital wall art listing featuring exactly NUMBER framed prints arranged in a staggered layout.

Layout:
- Exactly NUMBER frames only
- All NUMBER frames identical in size and style
- Frames must remain perfectly straight (no tilting or rotation)
- The center frame positioned slightly higher
- The left and right frames positioned slightly lower
- Even spacing between frames
- No additional frames anywhere in the scene

Scene:
A clean, minimal interior wall with no other wall art.

Frame:
- Thin modern frame (something that compliments the art)
- Subtle realistic depth
- Thin white mat
- Matte finish, no glare

Placement:
- Camera perfectly straight-on
- Frames aligned flat against the wall
- All artwork surfaces perfectly rectangular
- No perspective distortion
- All vertical and horizontal edges parallel

Lighting:
- Soft natural daylight
- Gentle realistic shadows
- Even lighting across all NUMBER prints

Composition:
- Final image square (1:1)
- All NUMBER frames fully visible
- No cropping of frames
- No extra objects or decorative frames

Style:
- Ultra realistic
- Clean professional product photography
- No text, no logos, no watermarks, no people

If more than NUMBER frames appear, or any frame is tilted, resized, duplicated, or distorted, regenerate the image.
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

; Room - Multi Piece - Staggered
Gemini_RoomMultiStaggeredPrompt(imageCount := "") {
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

Exactly NUMBER framed artworks must appear.
Do not add extra frames.
Do not duplicate any artwork.
Each artwork must appear once and only once.

Each artwork must remain completely unchanged:
- No color changes
- No cropping
- No stretching
- No warping
- No perspective distortion
- No style reinterpretation

Preserve each artwork’s original aspect ratio exactly.
Each frame opening must match its artwork’s exact proportions.

Create a photorealistic lifestyle mockup in a calm, cozy bedroom or personal room setting featuring a coordinated set of NUMBER framed prints arranged in a staggered layout.

Environment:
- Soft neutral wall tones (warm beige, cream, soft taupe)
- Cozy bedroom setting with subtle styling (bed with linen bedding, small nightstand, soft throw, minimal plant or lamp)
- Decor must not overlap or block the artwork
- The art set is the focal point of the scene
- Clean, peaceful, dreamy atmosphere

Layout:
- Exactly NUMBER identical frames
- All frames same size and style
- Center frame positioned slightly higher
- Left and right frames positioned slightly lower
- Even, intentional spacing between frames
- Frames perfectly straight, no tilting or rotation
- No resizing differences between frames

Frame:
- Thin modern frame (something that compliments the art)
- Subtle realistic depth
- Optional thin white mat sized proportionally
- Matte finish, no glare

Placement:
- Frames aligned flat against the wall
- Camera straight-on or very slightly angled
- All artwork surfaces perfectly rectangular
- Vertical and horizontal edges perfectly parallel
- No perspective distortion
- No cropping of frames

Lighting:
- Soft natural daylight entering from one side
- Warm, cozy, inviting atmosphere
- Gentle realistic shadows beneath frames
- Even lighting across all NUMBER artworks
- No glare or reflections obscuring artwork

Composition:
- Final output square (1:1)
- All NUMBER frames fully visible
- Artwork unobstructed
- Balanced, professionally styled lifestyle composition

Style:
- Ultra realistic lifestyle interior photography
- Soft depth of field in background only (not on artwork)
- No text
- No people
- No logos
- No watermarks

If more than NUMBER frames appear, or any frame is tilted, resized, duplicated, or distorted, regenerate the image.
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

; Office - Multi Piece - Staggered
Gemini_OfficeMultiStaggeredPrompt(imageCount := "") {
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

Exactly NUMBER framed artworks must be shown.
Do not add extra frames.
Do not duplicate any artwork.
Each artwork must appear once and only once.

Each artwork must remain completely unchanged:
- No color changes
- No cropping
- No stretching
- No warping
- No perspective distortion
- No style reinterpretation

Preserve each artwork’s original aspect ratio exactly.
Each frame opening must match its artwork’s exact proportions.

Create a photorealistic lifestyle mockup in a modern office or creative workspace featuring the NUMBER artworks arranged in a staggered layout.

Environment:
- Modern home office or creative workspace
- Desk positioned beneath or near the artwork
- Clean professional decor (minimal plant, lamp, notebook, monitor)
- Decor must not overlap or block the artwork
- Neutral wall tones

Layout:
- Exactly NUMBER identical frames
- All frames same size and style
- Center frame positioned slightly higher
- Left and right frames positioned slightly lower
- Clear vertical offset between center and side frames
- Even horizontal spacing
- Frames perfectly straight (no tilting or rotation)
- No resizing differences

Important:
Staggering refers only to vertical position.
Do not tilt, rotate, resize, or distort any frame.

Frame:
- Thin modern frame (something that compliments the art)
- Matte finish
- Subtle realistic depth

Placement:
- Artwork positioned naturally above desk or workspace
- Frames aligned flat against the wall
- Camera straight-on or slightly angled
- All artwork surfaces perfectly rectangular
- Vertical and horizontal edges parallel
- No perspective distortion

Lighting:
- Natural daylight or soft ambient office lighting
- Even lighting across all NUMBER artworks
- No glare or reflections

Composition:
- Final image square (1:1)
- All NUMBER frames fully visible
- Workspace visible but secondary
- Balanced, intentional staggered arrangement

Style:
- Ultra realistic professional interior photography
- No text
- No people
- No logos
- No watermarks

If more than NUMBER frames appear, or any frame is tilted, resized, duplicated, or distorted, regenerate the image.
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

; Living - Multi Piece - Staggered
Gemini_LivingMultiStaggeredPrompt(imageCount := "") {
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

Exactly NUMBER framed artworks must be shown.
Do not add extra frames.
Do not duplicate any artwork.
Each artwork must appear once and only once.

Each artwork must remain completely unchanged:
- No color changes
- No cropping
- No stretching
- No warping
- No perspective distortion
- No style reinterpretation

Preserve each artwork’s original aspect ratio exactly.
Each frame opening must match its artwork’s exact proportions.

Create a photorealistic lifestyle mockup in a modern living space featuring the NUMBER artworks arranged in a staggered layout.

Environment:
- Modern living room or lounge
- Sofa positioned beneath or near the artwork
- Subtle decor elements (throw pillows, coffee table, minimal plant)
- Neutral warm tones
- Decor must not block or overlap the artwork
- Artwork set is the focal point

Layout:
- Exactly NUMBER identical frames
- All frames same size and style
- Center frame positioned slightly higher
- Left and right frames positioned slightly lower
- Clear vertical offset between center and side frames
- Even horizontal spacing
- Frames perfectly straight (no tilting or rotation)
- No resizing differences between frames

Important:
Staggering refers only to vertical placement.
Do not tilt, rotate, resize, or distort any frame.

Frame:
- Modern thin frame (something that compliments the art)
- Realistic depth and subtle shadow
- Matte finish, no glare

Placement:
- Frames aligned flat against the wall
- Camera straight-on or very slightly angled
- All artwork surfaces perfectly rectangular
- Vertical and horizontal edges parallel
- No perspective distortion

Lighting:
- Soft natural light entering from one side
- Warm, inviting atmosphere
- Even lighting across all NUMBER artworks
- No glare or reflections

Composition:
- Final image square (1:1)
- All NUMBER frames fully visible
- Living space visible but secondary
- Balanced but intentionally staggered arrangement

Style:
- Ultra realistic interior photography
- No text
- No people
- No logos
- No watermarks

If more than NUMBER frames appear, or any frame is tilted, resized, duplicated, or distorted, regenerate the image.

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

; Statement - Multi Piece - Staggered
Gemini_StatementMultiStaggeredPrompt(imageCount := "") {
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

Exactly NUMBER framed artworks must be shown.
Do not add extra frames.
Do not duplicate any artwork.
Each artwork must appear once and only once.

Each artwork must remain completely unchanged:
- No color changes
- No cropping
- No stretching
- No warping
- No perspective distortion
- No style reinterpretation

Preserve each artwork’s original aspect ratio exactly.
Each frame opening must match its artwork’s exact proportions.

Create a dramatic, high-impact statement-room mockup featuring the NUMBER artworks arranged in a staggered layout.

Inspiration:
- Take inspiration from the artwork’s dreamy pastel tones and glowing highlights
- The environment should amplify the mood without overpowering the artwork
- The artwork must remain geometrically accurate

Environment:
- Loft, gallery-style room, or creative studio space
- Expressive atmosphere (subtle texture, architectural depth)
- No additional wall art
- Background elements must not overlap the artwork

Layout:
- Exactly NUMBER identical frames
- All frames same size and style
- Center frame positioned slightly higher
- Left and right frames positioned slightly lower
- Clear vertical offset between center and side frames
- Even horizontal spacing
- Frames perfectly straight (no tilting or rotation)
- No resizing differences

Important:
Staggering refers only to vertical placement.
Do not tilt, rotate, resize, or distort any frame.

Frame:
- Modern thin frame (something that compliments the art)
- Realistic depth and subtle shadow
- Matte finish, no glare

Placement:
- Frames prominently centered on the wall
- Camera straight-on or very slightly angled
- All artwork surfaces perfectly rectangular
- Vertical and horizontal edges parallel
- No lens distortion affecting the artwork plane

Lighting:
- Cinematic room lighting
- Directional lighting creating depth and mood
- Artwork evenly lit and fully visible
- No glare or reflection on artwork surface

Composition:
- Square (1:1) output
- All NUMBER frames fully visible
- Artwork set is the dominant focal point
- Dramatic editorial interior composition

Style:
- Ultra realistic editorial interior photography
- No text
- No people
- No logos
- No watermarks

If more than NUMBER frames appear, or any frame is tilted, resized, duplicated, or distorted, regenerate the image.
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

