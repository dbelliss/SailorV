pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--------------------------------------------------------------------------------
-- acknowledgements
    -- misato for the base game outline
    -- advanced micro platformer - starter kit by mhughson
        -- https://www.lexaloffle.com/bbs/?pid=37158#p37402

--------------------------------------------------------------------------------
game_states = {
    splash = 0,
    game = 1,
    gameover = 2
}

state = game_states.splash

function change_state()
    cls()
    if state == game_states.splash then
        state = game_states.game
    elseif state == game_states.game then
        state = game_states.gameover
    elseif state == game_states.gameover then
        state = game_states.splash
    end
end

--------------------------------------------------------------------------------
---------------------------------- player --------------------------------------
--------------------------------------------------------------------------------
function make_player(x,y)
  local player = {
    x=x,                 -- player x position

    y=y,                 -- player y position

    p_jump=-1.75,           -- jump velocity

    dx=0,

    dy=0,

    --max_dx=1,             -- max x speed

    --max_dy=2,             -- max y speed

    --p_width=8,            -- sprite width

    --p_height=16,          -- sprite height

    p_speed=0.05,         -- player acceleration force

    drag=0.05,            -- player drag force

    gravity=0.15,         -- gravity



    jump_button={
      update=function(self)
        if(btn(2)) then
          self.is_jumping=true
        else
          self.is_jumping=false
        end
      end
    },
    update=function(self)
      local b_left=btn(0)
      local b_right=btn(1)

      if b_left==true then
        self.dx-=self.p_speed
        b_right=false
      elseif b_right==true then
        self.dx+=self.p_speed
      else
        self.dx*=self.drag
      end

      self.x+=self.dx
      self.jump_button:update()

      if self.jump_button.is_jumping then
        self.dy=self.p_jump
      end

      self.dy+=self.gravity
      self.y+=self.dy


      if self.y>=120 then
        self.y = 120
      end
    end,

    draw=function(self)
      spr(1, self.x, self.y-8, 1, 2)
      print ('self.y:'..(self.y), 80, 10, 5)
    end
  }
  return player
end

-- player input

function handle_input()
end

-- pico8 game funtions

function _init()
    cls()
    p1=make_player(64,100)
end

function _update60()
    if state == game_states.splash then
        update_splash()
    elseif state == game_states.game then
        update_game()
    elseif state == game_states.gameover then
        update_gameover()
    end
end

function _draw()
    cls()
    if state == game_states.splash then
        draw_splash()
    elseif state == game_states.game then
        draw_game()
    elseif state == game_states.gameover then
        draw_gameover()
    end
end


-- splash

function update_splash()
    -- usually we want the player to press one button
     if btn(5) then
         change_state()
     end
end

function draw_splash()
    rectfill(0,0,screen_size,screen_size,11)
    local text = "hello world"
    write(text, text_x_pos(text), 52,7)
end

-- game

function update_game()
  p1:update()
end

function draw_game()
  p1:draw()
end


-- game over

function update_gameover()

end

function draw_gameover()

end

-- utils

-- change this if you use a different resolution like 64x64
screen_size = 128


-- calculate center position in x axis
-- this is asuming the text uses the system font which is 4px wide
function text_x_pos(text)
    local letter_width = 4

    -- first calculate how wide is the text
    local width = #text * letter_width

    -- if it's wider than the screen then it's multiple lines so we return 0
    if width > screen_size then
        return 0
    end

   return screen_size / 2 - flr(width / 2)

end

-- prints black bordered text
function write(text,x,y,color)
    for i=0,2 do
        for j=0,2 do
            print(text,x+i,y+j, 0)
        end
    end
    print(text,x+1,y+1,color)
end


-- returns if module of a/b == 0. equals to a % b == 0 in other languages
function mod_zero(a,b)
   return a - flr(a/b)*b == 0
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000800000808820288080000080882028800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700088202880029aaaa088202880029aaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700829aaaa008aa8f80829aaaa008aa8f800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000088aa8f8008aac8c088aa8f8008aac8c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000008aac8c00aaffff008aac8c00aaffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaffff00aa788000aaffff00aa788000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aa788a0aaf787000aa788a0aa7787000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000af787a000f777ff0af787a000ff77000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000f777000001110000f777f0000111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000111000011111000011100001111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000111100000f00f000111100000f0f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000ff00000f00800000f0f00008000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000080000000080800000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000