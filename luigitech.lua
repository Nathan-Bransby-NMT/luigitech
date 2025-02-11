--[[ LuigiTech | Version: 1.0.0 | Updated: 2025-02-12
  
  MIT License

  Copyright (c) 2025 Nathan Bransby

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

  Email: nathan@nlb-software.dev
  GitHub: https://github.com/Nathan-Bransby-NMT/luigitech
  Support: https://github.com/sponsors/Nathan-Bransby-NMT
  
  Description:
    A Logitech Gaming Script that provides customizable recoil compensation
    with dynamic adjustment capabilities and automatic reload detection.
]]

-- Constants
local DEFAULT_DELAY = 10
local DEFAULT_RECOIL = 1

-- Delay Constraints
local MIN_DELAY = 1
local MAX_DELAY = 100

-- Recoil Constraints
local MIN_RECOIL = 0
local MAX_RECOIL = 10
local DELAY_MODIFIER = 1
local RECOIL_MODIFIER = 1

-- Enums
local Key = {
    R_ALT = "ralt",
    R_SHIFT = "rshift",
    NUM_LOCK = "numlock",
    RELOAD = "r"
}

local Mouse = {
    LEFT = 1,
    MIDDLE = 2,
    RIGHT = 3,
    BACK = 4,
    FORWARD = 5
}

local recoil = DEFAULT_RECOIL
local delay = DEFAULT_DELAY

--[[
  Increases the recoil compensation value
  
  Increments the recoil value by RECOIL_MODIFIER if below MAX_RECOIL
  Outputs the new recoil value to the log
]]
local function IncreaseRecoil()
  if recoil < MAX_RECOIL then
    recoil = recoil + RECOIL_MODIFIER
    OutputLogMessage("Recoil compensation increased to: [" .. recoil .. delay .. "]\n")
  end
end

--[[
  Increases the delay between compensation adjustments
  
  Increments the delay value by DELAY_MODIFIER if below MAX_DELAY
]]
local function IncreaseDelay()
  if delay < MAX_DELAY then
    delay = delay + DELAY_MODIFIER
  end
end

--[[
  Decreases the recoil compensation value
  
  Decrements the recoil value by RECOIL_MODIFIER if above MIN_RECOIL
  Outputs the new recoil value to the log
]]
local function DecreaseRecoil()
  if recoil > MIN_RECOIL then
    recoil = recoil - RECOIL_MODIFIER
    OutputLogMessage("Recoil compensation decreased to: [" .. recoil .. delay .. "]\n")
  end
end

--[[
  Decreases the delay between compensation adjustments
  
  Decrements the delay value by DELAY_MODIFIER if above MIN_DELAY
]]
local function DecreaseDelay()
  if delay > MIN_DELAY then
    delay = delay - DELAY_MODIFIER
  end
end

--[[ Apply the aim compensation ]]
--[[
  Applies mouse movement compensation
  
  Moves the mouse vertically by the current recoil value
  Waits for the specified delay period
]]
local function ApplyCompensation()
  MoveMouseRelative(0, recoil)
  Sleep(delay)
end

--[[ IsAwaitingModifier

Checks if R_SHIFT is being held ]]
--[[
  Checks if modifier key is being held
  
  Returns:
    boolean: true if R_SHIFT is pressed, false otherwise
]]
local function IsAwaitingModifier()
  return IsModifierPressed(Key.R_SHIFT)
end


--[[
  Outputs firing statistics to the log
  
  Parameters:
    currentRecoil: Current recoil compensation value
    currentDelay: Current delay between compensations
    execTime: Execution time in milliseconds
]]
function ReadFireRateMsg(currentRecoil, currentDelay, execTime)
  fireRatio = "[" .. recoil .. ":" .. delay .. "]"
  message = string.format("Recoil dampened at %s and ran for: %d ms\n", fireRatio, execTime)
  OutputLogMessage(message)
end

--[[
  Outputs when an event is called when the state passed is true.
  
  Parameters:
    state: Whether to output event calls
    event: The event being called
    arg: The event argument value
]]
function DebugEventCalls(state, event, arg)
  if state then
    OutputLogMessage("Event: " .. event .. ", Arg: " .. tostring(arg) .. "\n")
  end
end

-- Script settings
getRunState = true
debugEventState = false
EnablePrimaryMouseButtonEvents(getRunState)

--[[
  Main event handler for mouse input
  
  Parameters:
    event: String identifying the type of event
    arg: Numeric identifier for the mouse button
  
  Events handled:
  - MOUSE_BUTTON_PRESSED (1): Left click + right click for compensation
  - Mouse wheel (2) + buttons 4/5: Recoil adjustment when NumLock is on
]]
function OnEvent(event, arg)
  DebugEventCalls(debugEventState, event, arg)
  if event == "MOUSE_BUTTON_PRESSED" then
    if arg == Mouse.LEFT then
      if IsMouseButtonPressed(Mouse.LEFT) and IsMouseButtonPressed(Mouse.RIGHT) then
        ClearLog()
        startTime = GetRunningTime()
        
        repeat
          ApplyCompensation()
        until not IsMouseButtonPressed(Mouse.LEFT)
        
        stopTime = GetRunningTime()
        execTime = (stopTime - startTime)
               
        ReadFireRateMsg(recoil, delay, execTime)
        
        if IsKeyLockOn(Key.NUM_LOCK) and execTime > 400 then
          PressAndReleaseKey(Key.RELOAD)
          OutputLogMessage("... Reloading Magazine!\n")
        end
      end
    elseif IsKeyLockOn(Key.NUM_LOCK) and IsMouseButtonPressed(Mouse.MIDDLE) then 
      if IsMouseButtonPressed(Mouse.FORWARD) then
        IncreaseRecoil()
      elseif IsMouseButtonPressed(Mouse.BACK) then
        DecreaseRecoil()
      end
    end
  end
end
