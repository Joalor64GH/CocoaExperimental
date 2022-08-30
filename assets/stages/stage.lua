local scrollX = 0.9
local scrollY = 0.9

function onCreate()
    makeLuaSprite("bg", "stages/stage/stageback", -600, -200)
    setScrollFactor("bg", scrollX, scrollY)
    addLuaSprite("bg")

    makeLuaSprite("stageFront", "stages/stage/stagefront", -650, 600)
    setScrollFactor("stageFront", scrollX, scrollY)
    scaleObject("stageFront", 1.1, 1.1)
    addLuaSprite("stageFront")

    if lowQuality == false then
        makeLuaSprite("stageLight", "stages/stage/stage_light", -125, -100)
        setScrollFactor("stageLight", scrollX, scrollY)
        scaleObject("stageLight", 1.1, 1.1)
        addLuaSprite("stageLight")

        makeLuaSprite("stageLight2", "stages/stage/stage_light", 1225, -100)
        setScrollFactor("stageLight2", scrollX, scrollY)
        scaleObject("stageLight2", 1.1, 1.1)
        setProperty("stageLight2.flipX", true)
        addLuaSprite("stageLight2")

        makeLuaSprite("stageCurtains", "stages/stage/stagecurtains", -500, -300)
        setScrollFactor("stageCurtains", 1.3, 1.3)
        scaleObject("stageCurtains", 0.9, 0.9)
        addLuaSprite("stageCurtains")
    end
end