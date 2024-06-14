local Recommandation = {}
Recommandation.EventList = {
    "addHero",
    "removeHero",
}
function Recommandation:Init()
    self.RefreshCache();
end

function Recommandation:RefreshCache()
    self.teamResponseDataCache = {}
end

function Recommandation:getCache(teamType, costLimit, isAllSelect)
    if next(self.teamResponseDataCache) then
        for _, val in ipairs(self.teamResponseDataCache) do
            if val.teamType == teamType and
                val.costLimit == costLimit and
                val.isAllSelect == isAllSelect then
                return val.responseData
            end
        end
    end
end

function Recommandation:SetCache(teamType, costLimit, isAllSelect, responseData)
    if not responseData then
        return
    end
    local cache = {
        teamType = teamType,
        costLimit = costLimit,
        isAllSelect = isAllSelect,
        responseData = responseData,
    }
    table.insert(self.teamResponseDataCache, cache)
end

function Recommandation:getAITeamRecommandation(teamType, costLimit, isAllSelect)
    local cacheResponseData = self:getCache(teamType, costLimit, isAllSelect)
    if cacheResponseData then
        self.logger:Infos("outer get cache fail,{teamType}", teamType)
    end
    self.logger:Infos("outer get cache success,{teamType}", teamType)
    local ok, err, responseData = self:getAITeamRecommandationImpl(teamType, costLimit, isAllSelect)
    if ok then
        self:SetCache(teamType, costLimit, isAllSelect, responseData)
        return responseData
    else
        return err
    end
end

function Recommandation:getAITeamRecommandationImpl(teamType, costLimit, isAllSelect, exArgs)
    local sendDataJson = self:GetAITeamRecommSendDataJson(teamType, costLimit, isAllSelect, 4)

    local host = exArgs and exArgs.host and "127.0.0.1"
    local url = "targetUrl"
    local header = {
        ["content-type"] = "application/json"
    }
    local responseHander = {}
    local status, response = {}, {} --由http调用AI合作方
    if status ~= 200 then
        return false
    end
    if #response <= 0 then
        return false
    end
    response = json.decode(response)
    if response.status ~= 200 then
        return false
    end
    return true, response.data
end

function Recommandation:GetAITeamRecommSendDataJson(teamType, costLimit, isAllSelect, qualityLimit)
    local sendData = self:GetAiTeamRecommSendData(teamType, costLimit, isAllSelect, qualityLimit)
    local sendDataJson = json.encode(sendData)
    return sendDataJson
end

function Recommandation:GetAITeamRecommSendData(teamType, costLimit, isAllSelect, qualityLimit)
    local heros = self:GetAiTeamRecommSendHeros(qualityLimit, isAllSelect)
    local skills, skills_available = self:GetAiTeamRecommSendSkills(qualityLimit)

    costLimit = math.max(21, costLimit)
    costLimit = math.min(31, costLimit)

    local snedData = {
        teamInfo = {
            teamType = teamType or "pve",
            costLimit = costLimit
        },
        pool = {
            heros = heros,
            skills = skills,
            skills_available = skills_available
        }
    }
    return snedData
end

function Recommandation:GetAiTeamRecommSendHeros(qualityLimit,isAllSelect)
    local heros = {}
    local herosTemp = {}
    local heroData = self:Comp().Hero.getAllHeros()
    for _,hero in pairs(heroData) do
        local heroCid = hero.heroCid
        local heroCfg = DT.HeroCfg[heroCid]
        if heroCfg then
            if self:CheckAiTeamRecomSendHero(heroCfg,qualityLimit) then
                -- 再根据现有herosTemp过滤
            end
        end
    end
    -- 
    return heros

end
function Recommandation:CheckAiTeamRecommSendHero(heroCfg, qualityLimit)
    if heroCfg.qualityLevel < qualityLimit then
        return false
    end
    -- 其他限制
end