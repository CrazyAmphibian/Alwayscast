local function replacespellfunction(spell_id,func) --mmmm, helper function. me lazy. (it will save on like 1kb so it's worth it)
for i=1,#actions do
	local spell=actions[i]
	if spell.id==spell_id then
		spell.action=func
		return i
	end
end
end

local function setspellattribute(spell_id,attribute,value)
if not attribute then return end
for i=1,#actions do
	local spell=actions[i]
	if spell.id==spell_id then
		spell[attribute]=value
		return i
	end
end
end

--adds 2 more instructions, how unfortunate.
--[[
MOVE
CALL
]]
--not like performance matters *that* much, this should only run once at startup, anyways :clueless:



--[[
###############
 GREEK LETTERS
###############
]]

setspellattribute("ALPHA","mana",30)
replacespellfunction("ALPHA",function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 15
			
			local data = {}
			
			if ( #discarded > 0 ) then
				data = discarded[1]
			elseif ( #hand > 0 ) then
				data = hand[1]
			elseif ( #deck > 0 ) then
				data = deck[1]
			else
				data = nil
			end
			
			local rec = check_recursion( data, recursion_level )
			
			if ( data ~= nil ) and ( rec > -1 ) then
				if data.mana<=mana then
					mana=mana-data.mana
					data.action(rec)
				else
					OnNotEnoughManaForAction()
				end
			end
			
			--draw_actions( 1, true )
		end)

setspellattribute("GAMMA","mana",30)
replacespellfunction("GAMMA",function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 15
			
			local data = {}
			
			if ( #deck > 0 ) then
				data = deck[#deck]
			elseif ( #hand > 0 ) then
				data = hand[#hand]
			else
				data = nil
			end
			
			local rec = check_recursion( data, recursion_level )
			
			if ( data ~= nil ) and ( rec > -1 ) then
				if data.mana<=mana then
					mana=mana-data.mana
					data.action(rec)
				else
					OnNotEnoughManaForAction()
				end
			end
			
			--draw_actions( 1, true )
		end)



setspellattribute("TAU","mana",75)
replacespellfunction("TAU",function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 35
			
			local data1 = {}
			local data2 = {}
			
			local s1 = ""
			local s2 = ""
			
			if ( #deck > 0 ) then
				s1 = "deck"
				data1 = deck[1]
			else
				data1 = nil
			end
			
			if ( #deck > 0 ) then
				s2 = "deck 2"
				data2 = deck[2]
			else
				data2 = nil
			end
			
			local rec1 = check_recursion( data1, recursion_level )
			local rec2 = check_recursion( data2, recursion_level )
			
			if ( data1 ~= nil ) and ( rec1 > -1 ) then
				-- print("1: " .. tostring(data1.id) .. ", " .. s1)
				if data1.mana<=mana then
					mana=mana-data1.mana
					data1.action(rec)
				else
					OnNotEnoughManaForAction()
				end
			end
			
			if ( data2 ~= nil ) and ( rec2 > -1 ) then
				-- print("2: " .. tostring(data2.id) .. ", " .. s2)
				if data2.mana<=mana then
					mana=mana-data2.mana
					data2.action(rec)
				else
					OnNotEnoughManaForAction()
				end
			end
			
			--draw_actions( 1, true )
		end)

setspellattribute("OMEGA","mana",250)
replacespellfunction("OMEGA",function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 50
			
			if ( discarded ~= nil ) then
				for i,data in ipairs( discarded ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( rec > -1 ) and ( data.id ~= "RESET" ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			if ( hand ~= nil ) then
				for i,data in ipairs( hand ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( ( data.recursive == nil ) or ( data.recursive == false ) ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			if ( deck ~= nil ) then
				for i,data in ipairs( deck ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( rec > -1 ) and ( data.id ~= "RESET" ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
		end)


setspellattribute("MU","mana",100)
replacespellfunction("MU",function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 50
			
			--do NOT pass go, do NOT collect 200$.
			
			--local firerate = c.fire_rate_wait
			--local reload = current_reload_time
			--local mana_ = mana
			
			if ( discarded ~= nil ) then
				for i,data in ipairs( discarded ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == 2 ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			if ( hand ~= nil ) then
				for i,data in ipairs( hand ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == 2 ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			if ( deck ~= nil ) then
				for i,data in ipairs( deck ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == 2 ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			--c.fire_rate_wait = firerate
			--current_reload_time = reload
			--mana = mana_
			
			draw_actions( 1, true )
		end)
		
setspellattribute("PHI","mana",100)	
replacespellfunction("PHI",function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 50
			
			--local firerate = c.fire_rate_wait
			--local reload = current_reload_time
			--local mana_ = mana
			
			if ( discarded ~= nil ) then
				for i,data in ipairs( discarded ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == 0 ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			if ( hand ~= nil ) then
				for i,data in ipairs( hand ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == 0 ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			if ( deck ~= nil ) then
				for i,data in ipairs( deck ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == 0 ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			--c.fire_rate_wait = firerate
			--current_reload_time = reload
			--mana = mana_
		end)
		
		
setspellattribute("SIGMA","mana",100)			
replacespellfunction("SIGMA",function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 30
			
			--local firerate = c.fire_rate_wait
			--local reload = current_reload_time
			--local mana_ = mana
			
			if ( discarded ~= nil ) then
				for i,data in ipairs( discarded ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == 1 ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			if ( hand ~= nil ) then
				for i,data in ipairs( hand ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == 1 ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			if ( deck ~= nil ) then
				for i,data in ipairs( deck ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == 1 ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			--c.fire_rate_wait = firerate
			--current_reload_time = reload
			--mana = mana_
			
			draw_actions( 1, true )
		end)

--honestly this shit still isn't worth using even when it's practically free
setspellattribute("ZETA","mana",5)	
replacespellfunction("ZETA",function( recursion_level, iteration )
			local entity_id = GetUpdatedEntityID()
			local x, y = EntityGetTransform( entity_id )
			local options = {}
			
			local children = EntityGetAllChildren( entity_id )
			local inventory = EntityGetFirstComponent( entity_id, "Inventory2Component" )
			
			if ( children ~= nil ) and ( inventory ~= nil ) then
				local active_wand = ComponentGetValue2( inventory, "mActiveItem" )
				
				for i,child_id in ipairs( children ) do
					if ( EntityGetName( child_id ) == "inventory_quick" ) then
						local wands = EntityGetAllChildren( child_id )
						
						if ( wands ~= nil ) then
							for k,wand_id in ipairs( wands ) do
								if ( wand_id ~= active_wand ) and EntityHasTag( wand_id, "wand" ) then
									local spells = EntityGetAllChildren( wand_id )
									
									if ( spells ~= nil ) then
										for j,spell_id in ipairs( spells ) do
											local comp = EntityGetFirstComponentIncludingDisabled( spell_id, "ItemActionComponent" )
											
											if ( comp ~= nil ) then
												local action_id = ComponentGetValue2( comp, "action_id" )
												
												table.insert( options, action_id )
											end
										end
									end
								end
							end
						end
					end
				end
			end
			
			if ( #options > 0 ) then
				SetRandomSeed( x + GameGetFrameNum(), y + 251 )
				
				local rnd = Random( 1, #options )
				local action_id = options[rnd]
				
				for i,data in ipairs( actions ) do
					if ( data.id == action_id ) then
						local rec = check_recursion( data, recursion_level )
						if ( rec > -1 ) then
							dont_draw_actions = true
							if data.mana<=mana then
								mana=mana-data.mana
								data.action(rec)
							else
								OnNotEnoughManaForAction()
							end
							dont_draw_actions = false
						end
						break
					end
				end
			end
			
			draw_actions( 1, true )
		end)



--the cool thing about this function is that you don't even need to check for if a mod is loaded.
setspellattribute("OVERCAST_BETA","mana",20)	
replacespellfunction("OVERCAST_BETA",function( recursion_level, iteration )
		c.fire_rate_wait = c.fire_rate_wait + 15
		
		local data = {}
		

		if ( #discarded > 0 ) then
			data = discarded[#discarded]
		else
			data = nil
		end
		
		local rec = check_recursion( data, recursion_level )
		
		if ( data ~= nil ) and ( rec > -1 ) then
			if data.mana<=mana then
				mana=mana-data.mana
				data.action(rec)
			else
				OnNotEnoughManaForAction()
			end
		end
		
		--draw_actions( 1, true )
	end)

--i'm not going to TOUCH theta. have you seen the library it uses? holy fuck that is some shitcode if i've ever seen it.

setspellattribute("EL_UPSILON","mana",80)	
replacespellfunction("EL_UPSILON",function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 50
			
			--local firerate = c.fire_rate_wait
			--local reload = current_reload_time
			--local mana_ = mana
			
			if ( discarded ~= nil ) then --... the devs do know that you don't need ~= nil if the type isn't a bool, right? whatever, keeping it there for the sake of consistnecy.
				for i,data in ipairs( discarded ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == ACTION_TYPE_MATERIAL ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			if ( hand ~= nil ) then
				for i,data in ipairs( hand ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == ACTION_TYPE_MATERIAL ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			if ( deck ~= nil ) then
				for i,data in ipairs( deck ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == ACTION_TYPE_MATERIAL ) and ( rec > -1 ) then
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
			
			--c.fire_rate_wait = firerate
			--current_reload_time = reload
			--mana = mana_
		end)


--[[
###############
   ADD ____
###############
]]

replacespellfunction("ADD_TRIGGER",function()
			local data = {}
			
			local how_many = 1
			
			if ( #deck > 0 ) then
				data = deck[1]
			else
				data = nil
			end
			
			if ( data ~= nil ) then
				while ( #deck >= how_many ) and ( ( data.type == ACTION_TYPE_MODIFIER ) or ( data.type == ACTION_TYPE_PASSIVE ) or ( data.type == ACTION_TYPE_OTHER ) or ( data.type == ACTION_TYPE_DRAW_MANY ) ) do
					if ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) and ( data.id ~= "ADD_TRIGGER" ) and ( data.id ~= "ADD_TIMER" ) and ( data.id ~= "ADD_DEATH_TRIGGER" ) then
						if ( data.type == ACTION_TYPE_MODIFIER ) then
							dont_draw_actions = true
							if data.mana<=mana then
								mana=mana-data.mana
								data.action(rec)
							else
								OnNotEnoughManaForAction()
							end
							dont_draw_actions = false
						end
					end
					how_many = how_many + 1
					data = deck[how_many]
				end
				
				if ( data ~= nil ) and ( data.related_projectiles ~= nil ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
					local target = data.related_projectiles[1]
					local count = data.related_projectiles[2] or 1
					
					for i=1,how_many do
						data = deck[1]
						table.insert( discarded, data )
						table.remove( deck, 1 )
					end
					
					local valid = false
					
					for i=1,#deck do
						local check = deck[i]
						
						if ( check ~= nil ) and ( ( check.type == ACTION_TYPE_PROJECTILE ) or ( check.type == ACTION_TYPE_STATIC_PROJECTILE ) or ( check.type == ACTION_TYPE_MATERIAL ) or ( check.type == ACTION_TYPE_UTILITY ) ) then
							valid = true
							break
						end
					end
					
					if ( data.uses_remaining ~= nil ) and ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1
						
						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if not reduce_uses then
							data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
						end
					end
					
					if valid then
						for i=1,count do
							add_projectile_trigger_hit_world(target, 1)
						end
					else
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
		end)
		
setspellattribute("ADD_TIMER","mana",10) --why do these cost more than trigger?		
replacespellfunction("ADD_TIMER",function()
			local data = {}
			
			local how_many = 1
			
			if ( #deck > 0 ) then
				data = deck[1]
			else
				data = nil
			end
			
			if ( data ~= nil ) then
				while ( #deck >= how_many ) and ( ( data.type == ACTION_TYPE_MODIFIER ) or ( data.type == ACTION_TYPE_PASSIVE ) or ( data.type == ACTION_TYPE_OTHER ) or ( data.type == ACTION_TYPE_DRAW_MANY ) ) do
					if ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) and ( data.id ~= "ADD_TRIGGER" ) and ( data.id ~= "ADD_TIMER" ) and ( data.id ~= "ADD_DEATH_TRIGGER" ) then
						if ( data.type == ACTION_TYPE_MODIFIER ) then
							dont_draw_actions = true
							if data.mana<=mana then
								mana=mana-data.mana
								data.action(rec)
							else
								OnNotEnoughManaForAction()
							end
							dont_draw_actions = false
						end
					end
					how_many = how_many + 1
					data = deck[how_many]
				end
				
				if ( data ~= nil ) and ( data.related_projectiles ~= nil ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
					local target = data.related_projectiles[1]
					local count = data.related_projectiles[2] or 1
					
					for i=1,how_many do
						data = deck[1]
						table.insert( discarded, data )
						table.remove( deck, 1 )
					end
					
					local valid = false
					
					for i=1,#deck do
						local check = deck[i]
						
						if ( check ~= nil ) and ( ( check.type == ACTION_TYPE_PROJECTILE ) or ( check.type == ACTION_TYPE_STATIC_PROJECTILE ) or ( check.type == ACTION_TYPE_MATERIAL ) or ( check.type == ACTION_TYPE_UTILITY ) ) then
							valid = true
							break
						end
					end
					
					if ( data.uses_remaining ~= nil ) and ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1
						
						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if not reduce_uses then
							data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
						end
					end
					
					if valid then
						for i=1,count do
							add_projectile_trigger_timer(target, 20, 1)
						end
					else
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
		end)
		
setspellattribute("ADD_DEATH_TRIGGER","mana",10)
replacespellfunction("ADD_DEATH_TRIGGER",function()
			local data = {}
			
			local how_many = 1
			
			if ( #deck > 0 ) then
				data = deck[1]
			else
				data = nil
			end
			
			if ( data ~= nil ) then
				while ( #deck >= how_many ) and ( ( data.type == ACTION_TYPE_MODIFIER ) or ( data.type == ACTION_TYPE_PASSIVE ) or ( data.type == ACTION_TYPE_OTHER ) or ( data.type == ACTION_TYPE_DRAW_MANY ) ) do
					if ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) and ( data.id ~= "ADD_TRIGGER" ) and ( data.id ~= "ADD_TIMER" ) and ( data.id ~= "ADD_DEATH_TRIGGER" ) then
						if ( data.type == ACTION_TYPE_MODIFIER ) then
							dont_draw_actions = true
							if data.mana<=mana then
								mana=mana-data.mana
								data.action(rec)
							else
								OnNotEnoughManaForAction()
							end
							dont_draw_actions = false
						end
					end
					how_many = how_many + 1
					data = deck[how_many]
				end
				
				if ( data ~= nil ) and ( data.related_projectiles ~= nil ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
					local target = data.related_projectiles[1]
					local count = data.related_projectiles[2] or 1
					
					for i=1,how_many do
						data = deck[1]
						table.insert( discarded, data )
						table.remove( deck, 1 )
					end
					
					local valid = false
					
					for i=1,#deck do
						local check = deck[i]
						
						if ( check ~= nil ) and ( ( check.type == ACTION_TYPE_PROJECTILE ) or ( check.type == ACTION_TYPE_STATIC_PROJECTILE ) or ( check.type == ACTION_TYPE_MATERIAL ) or ( check.type == ACTION_TYPE_UTILITY ) ) then
							valid = true
							break
						end
					end
					
					if ( data.uses_remaining ~= nil ) and ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1
						
						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if not reduce_uses then
							data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
						end
					end
					
					if valid then
						for i=1,count do
							add_projectile_trigger_death(target, 1)
						end
					else
						dont_draw_actions = true
						if data.mana<=mana then
							mana=mana-data.mana
							data.action(rec)
						else
							OnNotEnoughManaForAction()
						end
						dont_draw_actions = false
					end
				end
			end
		end)
		
setspellattribute("DIVIDE_2","mana",35)	-- y=15x+5	
setspellattribute("DIVIDE_3","mana",50)		
setspellattribute("DIVIDE_4","mana",65)		
setspellattribute("DIVIDE_10","mana",155)		
setspellattribute("DIVIDE_10","max_uses",-1)		
		
setspellattribute("BURST_X","max_uses",-1)
setspellattribute("BURST_X","mana",40)
setspellattribute("BURST_8","mana",25)




setspellattribute("TRANSMUTATION","max_uses",-1) --why was this limited in the first place?


setspellattribute("MATERIAL_BLOOD","max_uses",-1) --the odd one out, and for no real good reason, either.
--data/scripts/gun/gun_actions.lua:3230 Note( Petri ): 10.7.2019 - this could be just removed (vampirism, the limited uses in these is extremely silly)

setspellattribute("THUNDERBALL","max_uses",-1) --worse version of lightning bolt, let's be honest.

setspellattribute("DEATH_CROSS_BIG","max_uses",-1) --i don't think this needs to be limited, seeing as it's already penalized with more recharge and mana cost. (not to mention a bigger radius isn't always better because collateral)

setspellattribute("PIPE_BOMB","max_uses",-1) --these are a hassle to use because you need something else to detonate them.
setspellattribute("PIPE_BOMB_DEATH_TRIGGER","max_uses",-1) --like, just use dormant crystal man.


for _,v in ipairs({"A","B","C","D","E","F","GSHARP","A2"}) do
setspellattribute("OCARINA_"..v,"mana",5)
end
for _,v in ipairs({"A","D","DIS","E","G"}) do
setspellattribute("KANTELE_"..v,"mana",5)
end






