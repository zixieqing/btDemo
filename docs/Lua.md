
# Lua 相关

#### 局部变量上限
局部变量的存储限制
Lua 使用虚拟寄存器（virtual registers）来管理局部变量，每个函数（或代码块）的局部变量数量受 LUAI_MAXVARS 控制（默认值通常为 200）。

可通过修改 Lua 源码（luaconf.h 中的 LUAI_MAXVARS）调整上限，但一般不建议。

错误提示：若超出限制，会报错 "too many local variables"。
```lua
require "cocos.init"

local function main()
    require("app.Game"):create():run()
   local function triggerTooManyLocals()
    local v1 = 1
    local v2 = 2
    local v3 = 3
    local v4 = 4
    local v5 = 5
    local v6 = 6
    local v7 = 7
    local v8 = 8
    local v9 = 9
    local v10 = 10
    local v11 = 11
    local v12 = 12
    local v13 = 13
    local v14 = 14
    local v15 = 15
    local v16 = 16
    local v17 = 17
    local v18 = 18
    local v19 = 19
    local v20 = 20
    local v21 = 21
    local v22 = 22
    local v23 = 23
    local v24 = 24
    local v25 = 25
    local v26 = 26
    local v27 = 27
    local v28 = 28
    local v29 = 29
    local v30 = 30
    local v31 = 31
    local v32 = 32
    local v33 = 33
    local v34 = 34
    local v35 = 35
    local v36 = 36
    local v37 = 37
    local v38 = 38
    local v39 = 39
    local v40 = 40
    local v41 = 41
    local v42 = 42
    local v43 = 43
    local v44 = 44
    local v45 = 45
    local v46 = 46
    local v47 = 47
    local v48 = 48
    local v49 = 49
    local v50 = 50
    local v51 = 51
    local v52 = 52
    local v53 = 53
    local v54 = 54
    local v55 = 55
    local v56 = 56
    local v57 = 57
    local v58 = 58
    local v59 = 59
    local v60 = 60
    local v61 = 61
    local v62 = 62
    local v63 = 63
    local v64 = 64
    local v65 = 65
    local v66 = 66
    local v67 = 67
    local v68 = 68
    local v69 = 69
    local v70 = 70
    local v71 = 71
    local v72 = 72
    local v73 = 73
    local v74 = 74
    local v75 = 75
    local v76 = 76
    local v77 = 77
    local v78 = 78
    local v79 = 79
    local v80 = 80
    local v81 = 81
    local v82 = 82
    local v83 = 83
    local v84 = 84
    local v85 = 85
    local v86 = 86
    local v87 = 87
    local v88 = 88
    local v89 = 89
    local v90 = 90
    local v91 = 91
    local v92 = 92
    local v93 = 93
    local v94 = 94
    local v95 = 95
    local v96 = 96
    local v97 = 97
    local v98 = 98
    local v99 = 99
    local v100 = 100
    local v101 = 101
    local v102 = 102
    local v103 = 103
    local v104 = 104
    local v105 = 105
    local v106 = 106
    local v107 = 107
    local v108 = 108
    local v109 = 109
    local v110 = 110
    local v111 = 111
    local v112 = 112
    local v113 = 113
    local v114 = 114
    local v115 = 115
    local v116 = 116
    local v117 = 117
    local v118 = 118
    local v119 = 119
    local v120 = 120
    local v121 = 121
    local v122 = 122
    local v123 = 123
    local v124 = 124
    local v125 = 125
    local v126 = 126
    local v127 = 127
    local v128 = 128
    local v129 = 129
    local v130 = 130
    local v131 = 131
    local v132 = 132
    local v133 = 133
    local v134 = 134
    local v135 = 135
    local v136 = 136
    local v137 = 137
    local v138 = 138
    local v139 = 139
    local v140 = 140
    local v141 = 141
    local v142 = 142
    local v143 = 143
    local v144 = 144
    local v145 = 145
    local v146 = 146
    local v147 = 147
    local v148 = 148
    local v149 = 149
    local v150 = 150
    local v151 = 151
    local v152 = 152
    local v153 = 153
    local v154 = 154
    local v155 = 155
    local v156 = 156
    local v157 = 157
    local v158 = 158
    local v159 = 159
    local v160 = 160
    local v161 = 161
    local v162 = 162
    local v163 = 163
    local v164 = 164
    local v165 = 165
    local v166 = 166
    local v167 = 167
    local v168 = 168
    local v169 = 169
    local v170 = 170
    local v171 = 171
    local v172 = 172
    local v173 = 173
    local v174 = 174
    local v175 = 175
    local v176 = 176
    local v177 = 177
    local v178 = 178
    local v179 = 179
    local v180 = 180
    local v181 = 181
    local v182 = 182
    local v183 = 183
    local v184 = 184
    local v185 = 185
    local v186 = 186
    local v187 = 187
    local v188 = 188
    local v189 = 189
    local v190 = 190
    local v191 = 191
    local v192 = 192
    local v193 = 193
    local v194 = 194
    local v195 = 195
    local v196 = 196
    local v197 = 197
    local v198 = 198
    -- local v199 = 199
    -- local v200 = 200
    -- local v201 = 201  -- 这里会触发错误
end

triggerTooManyLocals()  -- 执行时报错：too many local variables (limit is 200)
    
end

local status, msg = xpcall(main, __G__TRACKBACK__)

```
