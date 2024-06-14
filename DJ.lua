local next = next

local DJ = {}

local function Node(id,connectNodeMap)
    return {
        id = id,
        connectNodeMap = connectNodeMap
    }
end
function DJ.GetPath(nodeMap,source,target)
    if source == target then
        return 0,{}
    end
    if not nodeMap[source] then
        return false
    end


    local S = {}
    local U = {}

    S[source] = {
        distance = 0,
        preNode = nil
    }
    local lastNodeId = source
    local lastDistance = 0

    local UpdateConnection = function ()
        local curNodeId = lastNodeId
        local curNode = nodeMap[curNodeId]
        local minDistance = S[curNodeId].distance
        local distance
        for id,dis in pairs(curNode) do
            if not S[id] then
                local node = nodeMap[id]
                U[id] = {
                    distance = dis + minDistance,
                    preNode = curNode
                }
            else
                
            end
        end
    end
end