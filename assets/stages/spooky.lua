function onCreate()
    if lowQuality == false then
        makeAnimatedBGSprite('halloweenBG', 'spooky/halloween_bg', -200, -100)
        addAnimationByPrefix('halloweenBG', 'strikeshit', 'halloweem bg lightning strike')
    else
        makeBGSprite('halloweenBG', 'spooky/halloween_bg', -200, -100)
    end
    addLuaSprite('halloweenBG')

    local width = getPropertyFromClass('FlxG', 'width')
    local height = getPropertyFromClass('FlxG', 'height')

    makeLuaText('width', width, 0, 500, 500)
    addLuaText('width')
    makeLuaText('height', height, 0, 500, 500)
    addLuaText('height')

    makeLuaSprite('halloweenWhite', nil, -width, -height)
    makeGraphicRGB('halloweenWhite', width, height, {255, 255, 255})
    setProperty('halloweenWhite.alpha', 0.0)
end

function onCreatePost()
    addLuaSprite('halloweenWhite')
end

function onBeatHit()
    local beat = getProperty('lightningStrikeBeat')
    local offset = getProperty('lightningOffset')

    if (getRandomBool(100) == true) then
        if lowQuality == false then
            playAnim('halloweenBG', 'strikeshit', true)
        end

        setProperty('halloweenWhite.alpha', 0.45)
        doTweenAlpha('coolTween', 'halloweenBG', 0.6, 0.075)
        runTimer('coolTimer', 0.15)
        callMethodFromGame('lightningStrikeShit', {})
    end
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'coolTimer' then
        doTweenAlpha('coolTween', 'halloweenBG', 0.0, 0.25)
    end
end