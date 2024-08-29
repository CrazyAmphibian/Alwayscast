--make the effect last 1 frame
local file="data/entities/misc/effect_regeneration.xml"
ModTextFileSetContent(file,ModTextFileGetContent(file):gsub('frames="150"','frames="5"'))
--and make it occur every frame
file="data/entities/projectiles/deck/regeneration_field.xml"
ModTextFileSetContent(file,ModTextFileGetContent(file):gsub('<Base','<GameAreaEffectComponent radius="28" frame_length="1"></GameAreaEffectComponent > <Base'))
ModTextFileSetContent(file,ModTextFileGetContent(file):gsub('<ProjectileComponent ','<ProjectileComponent \ndamage_every_x_frames="0"'))

