---
layout: default
---

# Tagging

When a Tag is nested within another Tag, the nested Tag becomes an attribute
  of the base tag. For instance, if you wanted to store the dates that a singer
  used certain addresses for, that singer being the lead singer for a track that
  included multiple bands simultaneously, then your tag tree would look something
  like this:
 Targets
  - TrackUID
  BAND
  - LEADPERFORMER
  -- ADDRESS
  --- DATE
  --- DATEEND
  -- ADDRESS
  --- DATE
In this way, it becomes possible to store any Tag as attributes of another
  tag.
Multiple items SHOULD never be stored as a list in a single TagString. If there
  is more than one tag of a certain type to be stored, then more than one SimpleTag
  SHOULD be used. 
For authoring Tags outside of EBML, the [following XML syntax is proposed](http://www.matroska.org/files/tags/matroskatags.dtd) [used in mkvmerge](http://www.bunkus.org/videotools/mkvtoolnix/doc/mkvmerge.html#mkvmerge.tags). Binary data SHOULD be stored using BASE64 encoding if it is being stored at authoring time.

## Why official tags matter

There is a debate between people who think all tags SHOULD be free and those who think all tags SHOULD be strict. If you look at this page you will realise we are in between.

Advanced-users application might let you put any tag in your file. But for the rest of the applications, they usually give you a basic list of tags you can use. Both have their needs. But it's usually a bad idea to use custom/exotic tags because you will probably be the only person to use this information even though everyone else could benefit from it. So hopefully when someone wants to put information in one's file, they will find an official one that fit them and hopefully use it ! If it's not in the list, this person can contact us any time for addition of such a missing tag. But it doesn't mean it will be accepted... Matroska files are not meant the become a whole database of people who made costumes for a film. A website would be better for that... It's hard to define what SHOULD be in and what doesn't make sense in a file. So we'll treat each request carefully.

We also need an official list simply for developpers to be able to display relevant information in their own design (if they choose to support a list of meta-information they SHOULD know which tag has the wanted meaning so that other apps could understand the same meaning).

## Tag translations
To be able to save tags from other systems to Matroska we need to translate them to our system. There is a translation table [on our site](othertagsystems/comparetable.html).

## Tag Formatting

* The TagName SHOULD always be written in all capital letters and contain no space.
* The fields with dates SHOULD have the following format: YYYY-MM-DD
    HH:MM:SS.MSS YYYY = Year, -MM = Month, -DD = Days, HH = Hours, :MM = Minutes,
    :SS = Seconds, :MSS = Milliseconds. To store less accuracy, you remove items
    starting from the right. To store only the year, you would use, "2004".
    To store a specific day such as May 1st, 2003, you would use "2003-05-01".
  
* Fields that require a Float SHOULD use the "."
    mark instead of the "," mark. To display it differently for another
    local, applications SHOULD support auto replacement on display. Also, a thousandths
    separator SHOULD NOT be used.
* For currency amounts, there SHOULD only be a numeric value in the Tag. Only
    numbers, no letters or symbols other than ".". For instance, you
    would store "15.59" instead of "$15.59USD".

## Target types

The TargetType element allows tagging of different parts that are inside or outside a given file. For example in an audio file with one song you could have information about the album it comes from and even the CD set even if it's not found in the file.

For application to know what kind of information (like TITLE) relates to a certain level (CD title or track title), we also need a set of official TargetType names. For now audio and video will have different values &amp; names. That also means the same tag name can have different meanings depending on where it is (otherwise we would end up with 15 TITLE_ tags).


<table style="width: 100%;"><tr><th>TargetTypeValue</th><th>Audio strings</th><th>Video strings</th><th>Comment</th></tr><tr><td>70</td><td>COLLECTION</td><td>COLLECTION</td><td>the high hierarchy consisting of many different lower items</td></tr><tr><td>60</td><td>EDITION / ISSUE / VOLUME / OPUS</td><td>SEASON / SEQUEL / VOLUME</td><td>a list of lower levels grouped together</td></tr><tr><td>50</td><td>ALBUM / OPERA / CONCERT</td><td>MOVIE / EPISODE / CONCERT</td><td>the most common grouping level of music and video (equals to an episode for TV series)</td></tr><tr><td>40</td><td>PART / SESSION</td><td>PART / SESSION</td><td>when an album or episode has different logical parts</td></tr><tr><td>30</td><td>TRACK / SONG</td><td>CHAPTER</td><td>the common parts of an album or a movie</td></tr><tr><td>20</td><td>SUBTRACK / PART / MOVEMENT</td><td>SCENE</td><td>corresponds to parts of a track for audio (like a movement)</td></tr><tr><td>10</td><td>-</td><td>SHOT</td><td>the lowest hierarchy found in music or movies</td></tr></table>

An upper level value tag applies to the lower level. That means if a CD has the same artist for all tracks, you just need to set the ARTIST tag at level 50 (ALBUM) and not to each TRACK (but you can). That also means that if some parts of the CD have no known ARTIST the value MUST be set to nothing (a void string "").

When a level doesn't exist it MUST NOT be specified in the files, so that the TOTAL_PARTS and PART_NUMBER elements match the same levels.

Here is an example of how these `organizational` tags work: If you set 10 TOTAL_PARTS to the ALBUM level (40) it means the album contains 10 lower parts. The lower part in question is the first lower level that is specified in the file. So if it's TRACK (30) then that means it contains 10 tracks. If it's MOVEMENT (20) that means it's 10 movements, etc.

## Official tags 

The following is a complete list of the supported Matroska
  Tags. While it is possible to use Tag names that are not listed below, this
  is not reccommended as compatability will be compromised. If you find that there
  is a Tag missing that you would like to use, then please contact the Matroska
  team for its inclusion in the specifications before the format reaches 1.0.



<table><tr><th colspan="5" id="nesting">Nesting Information (tags containing other tags)</th>
  </tr><tr><td>ORIGINAL</td>
    <td>-</td>
    <td>A special tag that is meant to have other tags inside (using nested tags) to describe the original work of art that this item is based on. All tags in this list can be used "under" the ORIGINAL tag like LYRICIST, PERFORMER, etc.</td>
  </tr><tr><td>SAMPLE</td>
    <td>-</td>
    <td>A tag that contains other tags to describe a sample used in the targeted item taken from another work of art. All tags in this list can be used "under" the SAMPLE tag like TITLE, ARTIST, DATE_RELEASED, etc.</td>
  </tr><tr id="country"><td>COUNTRY</td>
    <td>UTF-8</td>
    <td>The name of the country ([biblio ISO-639-2](http://lcweb.loc.gov/standards/iso639-2/englangn.html#two)) that is meant to have other tags inside (using nested tags) to country specific information about the item. All tags in this list can be used "under" the COUNTRY_SPECIFIC tag like LABEL, PUBLISH_RATING, etc.</td>
  </tr><tr><th colspan="3" style="color: #f00;">Colour coding</th></tr><tr class="subjective" style="text-align: center"><td colspan="3">subjective information</td></tr><tr class="version2" style="text-align: center"><td colspan="3">subject to change or removal</td></tr><tr><th title="Used as TagName">Tag Name</th>
    <th title="Defines if either TagString or TagBinary is used" style="white-space: nowrap">Type</th>
    <th>Description</th>
  </tr><tr id="Organizational"><th colspan="5">Organizational Information</th>
  </tr><tr><td>TOTAL_PARTS</td>
    <td style="white-space: nowrap">UTF-8</td>
    <td>Total number of parts defined at the first lower level. (e.g. if TargetType is ALBUM, the total number of tracks of an audio CD)</td>
  </tr><tr><td>PART_NUMBER</td>
    <td>UTF-8</td>
    <td>Number of the current part of the current level. (e.g. if TargetType is TRACK, the track number of an audio CD)</td>
  </tr><tr><td>PART_OFFSET</td>
    <td>UTF-8</td>
    <td>A number to add to PART_NUMBER when the parts at that level don't start at 1. (e.g. if TargetType is TRACK, the track number of the second audio CD)</td>
  </tr><tr id="titles"><th colspan="5">Titles</th>
  </tr><tr><td>TITLE</td>
    <td>UTF-8</td>
    <td>The title of this item. For example, for music you might
      label this "Canon in D", or for video's audio track you might use "English
      5.1" This is akin to the TIT2 tag in ID3.</td>
  </tr><tr><td>SUBTITLE</td>
    <td>UTF-8</td>
    <td>Sub Title of the entity.</td>
  </tr><tr id="nested"><th colspan="5">Nested Information (tags contained in other tags)</th>
  </tr><tr id="URL"><td>URL</td>
    <td>UTF-8</td>
    <td>URL corresponding to the tag it's included in.</td>
  </tr><tr><td>SORT_WITH</td>
    <td>UTF-8</td>
    <td>A child element to indicate what alternative value the parent tag can have to be sorted, for example "Pet Shop Boys" instead of "The Pet Shop Boys". Or "Marley Bob" and "Marley Ziggy" (no comma needed).</td>
  </tr><tr><td>INSTRUMENTS</td>
    <td>UTF-8</td>
    <td>The instruments that are being used/played, separated by a comma. It SHOULD be a child of the following tags: ARTIST, LEAD_PERFORMER or ACCOMPANIMENT.</td>
  </tr><tr id="Email"><td>EMAIL</td>
    <td>UTF-8</td>
    <td>Email corresponding to the tag it's included in.</td>
  </tr><tr id="Address"><td>ADDRESS</td>
    <td>UTF-8</td>
    <td>The physical address of the entity. The address SHOULD include a country code. It can be useful for a recording label.</td>
  </tr><tr id="Fax"><td>FAX</td>
    <td>UTF-8</td>
    <td>The fax number corresponding to the tag it's included in. It can be useful for a recording label.</td>
  </tr><tr id="Phone"><td>PHONE</td>
    <td>UTF-8</td>
    <td>The phone number corresponding to the tag it's included in. It can be useful for a recording label.</td>
  </tr><tr id="Entities"><th colspan="5">Entities</th>
  </tr><tr><td>ARTIST</td>
    <td>UTF-8</td>
    <td>A person or band/collective generally considered responsible for the work. This is akin to the [TPE1 tag in ID3](http://id3.org/id3v2.3.0#TPE1).</td>
  </tr><tr><td>LEAD_PERFORMER</td>
    <td>UTF-8</td>
    <td>Lead Performer/Soloist(s). This can sometimes be the same as ARTIST.</td>
  </tr><tr><td>ACCOMPANIMENT</td>
    <td>UTF-8</td>
    <td>Band/orchestra/accompaniment/musician. This is akin to the [TPE2 tag in ID3](http://id3.org/id3v2.3.0#TPE2).</td>
  </tr><tr><td>COMPOSER</td>
    <td>UTF-8</td>
    <td>The name of the composer of this item. This is akin to the [TCOM tag in ID3](http://id3.org/id3v2.3.0#TCOM).</td>
  </tr><tr><td>ARRANGER</td>
    <td>UTF-8</td>
    <td>The person who arranged the piece, e.g., Ravel.</td>
  </tr><tr><td>LYRICS</td>
    <td>UTF-8</td>
    <td>The lyrics corresponding to a song (in case audio synchronization is not known or as a doublon to a subtitle track). Editing this value when subtitles are found SHOULD also result in editing the subtitle track for more consistency.</td>
  </tr><tr><td>LYRICIST</td>
    <td>UTF-8</td>
    <td>The person who wrote the lyrics for a musical item. This is akin to
      the [TEXT](http://id3.org/id3v2.3.0#TEXT) tag in ID3.</td>
  </tr><tr><td>CONDUCTOR</td>
    <td>UTF-8</td>
    <td>Conductor/performer refinement. This is akin to the [TPE3](http://id3.org/id3v2.3.0#TPE3).</td>
  </tr><tr><td>DIRECTOR</td>
    <td>UTF-8</td>
    <td>This is akin to the [IART tag in RIFF](http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/RIFF.html).</td>
  </tr><tr><td>ASSISTANT_DIRECTOR</td>
    <td>UTF-8</td>
    <td>The name of the assistant director.</td>
  </tr><tr><td>DIRECTOR_OF_PHOTOGRAPHY</td>
    <td>UTF-8</td>
    <td>The name of the director of photography, also known as cinematographer. This is akin to the ICNM tag in Extended RIFF.</td>
  </tr><tr><td>SOUND_ENGINEER</td>
    <td>UTF-8</td>
    <td>The name of the sound engineer or sound recordist.</td>
  </tr><tr><td>ART_DIRECTOR</td>
    <td>UTF-8</td>
    <td>The person who oversees the artists and craftspeople who build the sets.</td>
  </tr><tr><td>PRODUCTION_DESIGNER</td>
    <td>UTF-8</td>
    <td>Artist responsible for designing the overall visual appearance of a movie.</td>
  </tr><tr><td>CHOREGRAPHER</td>
    <td>UTF-8</td>
    <td>The name of the choregrapher</td>
  </tr><tr><td>COSTUME_DESIGNER</td>
    <td>UTF-8</td>
    <td>The name of the costume designer</td>
  </tr><tr><td>ACTOR</td>
    <td>UTF-8</td>
    <td>An actor or actress playing a role in this movie. This is the person's
    real name, not the character's name the person is playing.</td>
  </tr><tr><td>CHARACTER</td>
    <td>UTF-8</td>
    <td>The name of the character an actor or actress plays in this
    movie. This SHOULD be a sub-tag of an <code>ACTOR</code> tag in order not
    to cause ambiguities.</td>
  </tr><tr><td>WRITTEN_BY</td>
    <td>UTF-8</td>
    <td>The author of the story or script (used for movies and TV shows).</td>
  </tr><tr><td>SCREENPLAY_BY</td>
    <td>UTF-8</td>
    <td>The author of the screenplay or scenario (used for movies and TV shows).</td>
  </tr><tr><td>EDITED_BY</td>
    <td>UTF-8</td>
    <td>This is akin to the IEDT tag in Extended RIFF.</td>
  </tr><tr><td>PRODUCER</td>
    <td>UTF-8</td>
    <td>Produced by. This is akin to the IPRO tag in Extended RIFF.</td>
  </tr><tr><td>COPRODUCER</td>
    <td>UTF-8</td>
    <td>The name of a co-producer.</td>
  </tr><tr><td>EXECUTIVE_PRODUCER</td>
    <td>UTF-8</td>
    <td>The name of an executive producer.</td>
  </tr><tr><td>DISTRIBUTED_BY</td>
    <td>UTF-8</td>
    <td>This is akin to the IDST tag in Extended RIFF.</td>
  </tr><tr><td>MASTERED_BY</td>
    <td>UTF-8</td>
    <td>The engineer who mastered the content for a physical medium or for digital distribution.</td>
  </tr><tr><td>ENCODED_BY</td>
    <td>UTF-8</td>
    <td>This is akin to the [TENC tag](http://id3.org/id3v2.3.0#TENC) in ID3.</td>
  </tr><tr><td>MIXED_BY</td>
    <td>UTF-8</td>
    <td>DJ mix by the artist specified</td>
  </tr><tr><td>REMIXED_BY</td>
    <td>UTF-8</td>
    <td>Interpreted, remixed, or otherwise modified by. This is akin to the [TPE4 tag in ID3](http://id3.org/id3v2.3.0#TPE4).</td>
  </tr><tr><td>PRODUCTION_STUDIO</td>
    <td>UTF-8</td>
    <td>This is akin to the ISTD tag in Extended RIFF.</td>
  </tr><tr><td>THANKS_TO</td>
    <td>UTF-8</td>
    <td>A very general tag for everyone else that wants to be listed.</td>
  </tr><tr><td>PUBLISHER</td>
    <td>UTF-8</td>
    <td>This is akin to the [TPUB tag in ID3](http://id3.org/id3v2.3.0#TPUB).</td>
  </tr><tr><td>LABEL</td>
    <td>UTF-8</td>
    <td>The record label or imprint on the disc.</td>
  </tr><tr id="Search"><th colspan="5">Search / Classification</th>
  </tr><tr class="subjective" id="Genre"><td>GENRE</td>
    <td>UTF-8</td>
    <td>The main genre (classical, ambient-house, synthpop, sci-fi, drama, etc). The format follows the infamous TCON tag in ID3.</td>
  </tr><tr class="subjective" id="Mood"><td>MOOD</td>
    <td>UTF-8</td>
    <td>Intended to reflect the mood of the item with a few keywords, e.g. "Romantic", "Sad" or "Uplifting". The format follows that of the TMOO tag in ID3.</td>
  </tr><tr id="OriginalMediaType"><td>ORIGINAL_MEDIA_TYPE</td>
    <td>UTF-8</td>
    <td>Describes the original type of the media, such as, "DVD",
      "CD", "computer image," "drawing," "lithograph," and so forth. This is akin to the [TMED tag in ID3](http://id3.org/id3v2.3.0#TMED).</td>
  </tr><tr id="Type"><td>CONTENT_TYPE</td>
    <td>UTF-8</td>
    <td>The type of the item. e.g. Documentary, Feature Film, Cartoon, Music Video, Music, Sound FX, ...</td>
  </tr><tr id="Subject"><td>SUBJECT</td>
    <td>UTF-8</td>
    <td>Describes the topic of the file, such as "Aerial view of Seattle."</td>
  </tr><tr id="Description"><td>DESCRIPTION</td>
    <td>UTF-8</td>
    <td>A short description of the content, such as "Two birds flying."</td>
  </tr><tr id="Keywords"><td>KEYWORDS</td>
    <td>UTF-8</td>
    <td>Keywords to the item separated by a comma, used for searching.</td>
  </tr><tr><td>SUMMARY</td>
    <td>UTF-8</td>
    <td>A plot outline or a summary of the story.</td>
  </tr><tr><td>SYNOPSIS</td>
    <td>UTF-8</td>
    <td>A description of the story line of the item. </td>
  </tr><tr id="InitialKey"><td>INITIAL_KEY</td>
    <td>UTF-8</td>
    <td>The initial key that a musical track starts in. The format is identical
      to ID3.</td>
  </tr><tr><td>PERIOD</td>
    <td>UTF-8</td>
    <td>Describes the period that the piece is from or about. For example, "Renaissance". </td>
  </tr><tr id="law_rating"><td>LAW_RATING</td>
    <td>UTF-8</td>
    <td>Depending on the [country](#country) it's the format of the rating of a movie (P, R, X in the USA, an age in other countries or a URI defining a logo).</td>
  </tr><tr id="icra"><td>ICRA</td>
    <td>binary</td>
    <td>The [ICRA](http://www.icra.org/) content rating for parental control. (Previously RSACi)</td>
  </tr><tr id="Temporal"><th colspan="5">Temporal Information</th>
  </tr><tr><td>DATE_RELEASED</td>
    <td>UTF-8</td>
    <td>The time that the item was originaly released. This is akin to the TDRL
      tag in ID3.</td>
  </tr><tr><td>DATE_RECORDED</td>
    <td>UTF-8</td>
    <td>The time that the recording began. This is akin to the TDRC
      tag in ID3.</td>
  </tr><tr><td>DATE_ENCODED</td>
    <td>UTF-8</td>
    <td>The time that the encoding of this item was completed began. This is akin to the TDEN tag in ID3.</td>
  </tr><tr><td>DATE_TAGGED</td>
    <td>UTF-8</td>
    <td>The time that the tags were done for this item. This is akin to the TDTG tag in ID3.</td>
  </tr><tr><td>DATE_DIGITIZED</td>
    <td>UTF-8</td>
    <td>The time that the item was tranfered to a digital medium. This is akin to the IDIT tag in RIFF.</td>
  </tr><tr><td>DATE_WRITTEN</td>
    <td>UTF-8</td>
    <td>The time that the writing of the music/script began. </td>
  </tr><tr><td>DATE_PURCHASED</td>
    <td>UTF-8</td>
    <td>Information on when the file was purchased (see also [purchase tags](#commercial)).</td>
  </tr><tr id="Spacial"><th colspan="5">Spacial Information</th>
  </tr><tr><td>RECORDING_LOCATION</td>
    <td>UTF-8</td>
    <td>The location where the item was recorded. The countries corresponding to the string, same 2 octets as in [Internet domains](http://www.iana.org/cctld/cctld-whois.htm), or possibly [ISO-3166](http://www.iso.org/iso/country_codes). This code is followed by a comma, then more detailed information such as state/province, another comma, and then city. For example, "US, Texas, Austin". This will allow for easy sorting. It is okay to only store the country, or the country and the state/province. More detailed information can be added after the city through the use of additional commas. In cases where the province/state is unknown, but you want to store the city, simply leave a space between the two commas. For example, "US, , Austin". </td>
  </tr><tr><td>COMPOSITION_LOCATION</td>
    <td>UTF-8</td>
    <td>Location that the item was originaly designed/written. The countries corresponding to the string, same 2 octets as in [Internet domains](http://www.iana.org/cctld/cctld-whois.htm), or possibly [ISO-3166](http://www.iso.org/iso/country_codes). This code is followed by a comma, then more detailed information such as state/province, another comma, and then city. For example, "US, Texas, Austin". This will allow for easy sorting. It is okay to only store the country, or the country and the state/province. More detailed information can be added after the city through the use of additional commas. In cases where the province/state is unknown, but you want to store the city, simply leave a space between the two commas. For example, "US, , Austin".</td>
  </tr><tr><td>COMPOSER_NATIONALITY</td>
    <td>UTF-8</td>
    <td>Nationality of the main composer of the item, mostly for classical music. The countries corresponding to the string, same 2 octets as in [Internet domains](http://www.iana.org/cctld/cctld-whois.htm), or possibly [ISO-3166](http://www.iso.org/iso/country_codes).</td>
  </tr><tr id="Personal"><th colspan="5">Personal</th>
  </tr><tr class="subjective"><td>COMMENT</td>
    <td>UTF-8</td>
    <td>Any comment related to the content.</td>
  </tr><tr class="subjective" id="PlayCounter"><td>PLAY_COUNTER</td>
    <td>UTF-8</td>
    <td>The number of time the item has been played.</td>
  </tr><tr class="subjective" id="rating"><td>RATING</td>
    <td>UTF-8</td>
    <td>A numeric value defining how much a person likes the song/movie. The number is between 0 and 5 with decimal values possible (e.g. 2.7), 5(.0) being the highest possible rating. Other rating systems with different ranges will have to be scaled.</td>
  </tr><tr id="Technical"><th colspan="5">Technical Information</th>
  </tr><tr id="Encoder"><td>ENCODER</td>
    <td>UTF-8</td>
    <td>The software or hardware used to encode this item. ("LAME" or "XviD")</td>
  </tr><tr id="EncodeSettings"><td>ENCODER_SETTINGS</td>
    <td>UTF-8</td>
    <td>A list of the settings used for encoding this item. No specific format.</td>
  </tr><tr id="BitsPS"><td>BPS</td>
    <td>UTF-8</td>
    <td>The average bits per second of the specified item. This is only the data
      in the Blocks, and excludes headers and any container overhead.</td>
  </tr><tr id="FramesPS"><td>FPS</td>
    <td>UTF-8</td>
    <td>The average frames per second of the specified item. This is typically
      the average number of Blocks per second. In the event that lacing is used,
      each laced chunk is to be counted as a seperate frame. </td>
  </tr><tr id="BPM"><td>BPM</td>
    <td>UTF-8</td>
    <td>Average number of beats per minute in the complete target (e.g. a chapter). Usually a decimal number.</td>
  </tr><tr id="MEASURE"><td>MEASURE</td>
    <td>UTF-8</td>
    <td>In music, a measure is a unit of time in Western music like "4/4". It represents a regular grouping of beats, a meter, as indicated in musical notation by the time signature.. The majority of the contemporary rock and pop music you hear on the radio these days is written in the 4/4 time signature.</td>
  </tr><tr id="TUNING"><td>TUNING</td>
    <td>UTF-8</td>
    <td>It is saved as a frequency in hertz to allow near-perfect tuning of instruments to the same tone as the musical piece (e.g. "441.34" in Hertz). The default value is 440.0 Hz.</td>
  </tr><tr id="REPLAYGAIN_GAIN"><td>REPLAYGAIN_GAIN</td>
    <td>binary</td>
    <td>The gain to apply to reach 89dB SPL on playback. This is based on the [Replay Gain standard](http://www.replaygain.org/). Note that ReplayGain information can be found at all TargetType levels (track, album, etc).</td>
  </tr><tr id="REPLAYGAIN_PEAK"><td>REPLAYGAIN_PEAK</td>
    <td>binary</td>
    <td>The maximum absolute peak value of the item. This is based on the [Replay Gain standard](http://www.replaygain.org/).</td>
  </tr><tr id="identifiers"><th colspan="5">Identifiers</th>
  </tr><tr><td>ISRC</td>
    <td>UTF-8</td>
    <td>The [International Standard Recording Code](http://www.ifpi.org/isrc/isrc_handbook.html#Heading198), excluding the "ISRC" prefix and including hyphens.</td>
  </tr><tr><td>MCDI</td>
    <td>binary</td>
    <td>This is a binary dump of the TOC of the CDROM that this item was taken from. This holds the same information as the MCDI in ID3.</td>
  </tr><tr><td>ISBN</td>
    <td>UTF-8</td>
    <td>[International Standard Book Number](http://www.isbn-international.org/)</td>
  </tr><tr><td>BARCODE</td>
    <td>UTF-8</td>
    <td>[EAN-13](http://www.ean-int.org/) (European Article Numbering) or [UPC-A](http://www.uc-council.org/) (Universal Product Code) bar code identifier </td>
  </tr><tr><td>CATALOG_NUMBER</td>
    <td>UTF-8</td>
    <td>A label-specific string used to identify the release (TIC 01 for example).</td>
  </tr><tr><td>LABEL_CODE</td>
    <td>UTF-8</td>
    <td>A 4-digit or 5-digit number to identify the record label, typically printed as (LC) xxxx or (LC) 0xxxx on CDs medias or covers (only the number is stored).</td>
  </tr><tr><td>LCCN</td>
    <td>UTF-8</td>
    <td>[Library of Congress Control Number](http://www.loc.gov/marc/lccn.html)</td>
  </tr><tr id="commercial"><th colspan="5">Commercial</th>
  </tr><tr><td>PURCHASE_ITEM</td>
    <td>UTF-8</td>
    <td>URL to purchase this file. This is akin to the WPAY tag
      in ID3.</td>
  </tr><tr><td>PURCHASE_INFO</td>
    <td>UTF-8</td>
    <td>Information on where to purchase this album. This is akin to the WCOM
      tag in ID3.</td>
  </tr><tr><td>PURCHASE_OWNER</td>
    <td>UTF-8</td>
    <td>Information on the person who purchased the file. This is akin
      to the [TOWN tag in ID3](http://id3.org/id3v2.3.0#TOWN).</td>
  </tr><tr id="Price"><td>PURCHASE_PRICE</td>
    <td>UTF-8</td>
    <td>The amount paid for entity. There SHOULD only be a numeric value in here.
      Only numbers, no letters or symbols other than ".". For instance,
      you would store "15.59" instead of "$15.59USD".</td>
  </tr><tr id="Currency"><td>PURCHASE_CURRENCY</td>
    <td>UTF-8</td>
    <td>The currency type used to pay for the entity. Use [ISO-4217](http://www.xe.com/iso4217.htm) for the 3 letter currency code.</td>
  </tr><tr id="legal"><th colspan="5">Legal</th>
  </tr><tr><td>COPYRIGHT</td>
    <td>UTF-8</td>
    <td>The copyright information as per the copyright holder. This is akin to
      the TCOP tag in ID3.</td>
  </tr><tr><td>PRODUCTION_COPYRIGHT</td>
    <td>UTF-8</td>
    <td>The copyright information as per the production copyright holder. This
      is akin to the TPRO tag in ID3.</td>
  </tr><tr><td>LICENSE</td>
    <td>UTF-8</td>
    <td>The license applied to the content (like Creative Commons variants).</td>
  </tr><tr><td>TERMS_OF_USE</td>
    <td>UTF-8</td>
    <td>The terms of use for this item. This is akin to the USER tag in ID3.</td>
  </tr></table>

## Notes

* In the Target list, a logicial OR is applied on all tracks, a logicial OR is applied on all chapters. Then a logical AND is applied between the Tracks list and the Chapters list to know if an element belongs to this Target.
