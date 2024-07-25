--- 深度优先搜素
---@class DepthFirstSearch
--[[

**定义：**
深度优先搜索（DFS）是一种用于遍历或搜索树或图的算法。它从一个起始节点开始，沿着一条路径深入到最深的节点，然后回溯到上一个节点，继续探索其他路径。

**特点：**
1. **递归或栈实现**：DFS可以通过递归或使用栈来实现。
2. **空间复杂度**：在最坏情况下，DFS的空间复杂度为O(h)，其中h是树的高度。
3. **不一定找到最优解**：DFS可能会找到一个解，但不一定是最优解。
4. **适合于解空间较大的问题**：在某些情况下，DFS比广度优先搜索（BFS）更有效。

**应用场景：**
- **路径查找**：在迷宫、图形等场合寻找路径。
- **连通性检测**：检查图中是否存在路径连接两个节点。
- **拓扑排序**：在有向无环图（DAG）中进行排序。
- **解决组合问题**：如八皇后问题、数独等。

特定应用：
对于需要探索所有可能路径的问题，如八皇后问题
在某些情况下，DFS的空间复杂度较低，尤其是图的深度较小且宽度较大的时候。
]]

local DepthFirstSearch = class("DepthFirstSearch")
function DepthFirstSearch:ctor(...)
    local graph = {
        A = {"B", "C"},
        B = {"D", "E"},
        C = {"F"},
        D = {},
        E = {},
        F = {}
    }
    
    local function dfs(node, visited)
        if not visited[node] then
            print(node)  -- 访问节点
            visited[node] = true  -- 标记为已访问
    
            for _, neighbor in ipairs(graph[node]) do
                dfs(neighbor, visited)  -- 递归访问邻居节点
            end
        end
    end
    
    -- 主程序
    local visited = {}
    dfs("A", visited)
end

---八皇后问题：八皇后问题是一个经典的回溯算法问题，目标是在8×8的棋盘上放置8个皇后，使得它们彼此之间不能相互攻击。换句话说，任何两个皇后都不能在同一行、同一列或同一斜线上。
--[[
常识：
1.回溯算法是什么
回溯算法是一种系统性地遍历所有可能解的算法，它的核心思想是通过递归尝试构造解，并在发现当前路径不满足条件时“回溯”到上一步，尝试其他可能的选择。
--]]
function DepthFirstSearch:solve_n_queens(...)
    local N = 8  -- 皇后数量
    local board = {}
    local solutions = {}

    -- 初始化棋盘
    for i = 1, N do
        board[i] = {}
        for j = 1, N do
            board[i][j] = 0  -- 0表示空位
        end
    end

    -- 检查当前位置是否安全
    local function is_safe(row, col)
        for i = 1, row - 1 do
            if board[i][col] == 1 then
                return false  -- 检查列
            end
            if col - (row - i) >= 1 and board[i][col - (row - i)] == 1 then
                return false  -- 检查左斜线
            end
            if col + (row - i) <= N and board[i][col + (row - i)] == 1 then
                return false  -- 检查右斜线
            end
        end
        return true
    end

    -- 回溯算法
    local function solve_n_queens(row)
        if row > N then
            -- 找到一个解，保存结果
            local solution = {}
            for i = 1, N do
                local line = ""
                for j = 1, N do
                    if board[i][j] == 1 then
                        line = line .. "Q "  -- 皇后
                    else
                        line = line .. ". "  -- 空位
                    end
                end
                table.insert(solution, line)
            end
            table.insert(solutions, solution)
            return
        end

        for col = 1, N do
            if is_safe(row, col) then
                board[row][col] = 1  -- 放置皇后
                solve_n_queens(row + 1)  -- 递归放置下一个皇后
                board[row][col] = 0  -- 回溯，移除皇后
            end
        end
    end

    -- 开始解决八皇后问题
    solve_n_queens(1)

    -- 打印所有解决方案
    for index, solution in ipairs(solutions) do
        print("Solution " .. index .. ":")
        for _, line in ipairs(solution) do
            print(line)
        end
        print("\n")
    end

end


return DepthFirstSearch