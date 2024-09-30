---------------------------------------------------------------------
-- File: Cell\RaidDebuffs\RaidDebuffs_BfA.lua
-- Author: enderneko (enderneko-dev@outlook.com)
-- Created : 2022-08-05 16:11:24 +08:00
-- Modified: 2024-10-02 12:49 +08:00
---------------------------------------------------------------------

local _, Cell = ...
local L = Cell.L
local F = Cell.funcs

-- taken from Grid2
local debuffs = {
    [1028] = { -- 艾泽拉斯
        [2378] = { -- 大女皇夏柯扎拉
        },
        [2381] = { -- 碎地者弗克拉兹
        },
        [2363] = { -- 维科玛拉
        },
        [2362] = { -- 奥玛斯，缚魂者
        },
        [2329] = { -- 森林之王伊弗斯
        },
        [2212] = { -- 雄狮之吼
        },
        [2213] = { -- 末日之嚎
        },
        [2139] = { -- 提赞
            261605, -- Consuming Spirits
            261552, -- Terror Wail
        },
        [2141] = { -- 基阿拉克
            260989, -- Storm Wing
            261509, -- Clutch
        },
        [2197] = { -- 冰雹构造体
            274895, -- Freezing Tempest
            274891, -- Glacial Breath
        },
        [2198] = { -- 战争使者耶纳基兹
            274932, -- Endless Abyss
            274904, -- Reality Tear
        },
        [2199] = { -- 蔚索斯，飞翼台风
            274839, -- Azurethos' Fury
        },
        [2210] = { -- 食沙者克劳洛克
            275175, -- Sonic Bellow
        },
    },

    [1031] = { -- 奥迪尔
        [2168] = { -- 塔罗克
            271222, -- Plasma Discharge
            270290, -- Blood Storm
            275270, -- Fixate
            275189, -- Hardened Arteries
            275205, -- Enlarged Heart
        },
        [2167] = { -- 纯净圣母
            267821, -- Defense Grid
            267787, -- Sanitizing Strike
            268095, -- Cleansing Purge
            268198, -- Clinging Corruption
            268253, -- Surgical Beam
            268277, -- Purifying Flame
        },
        [2146] = { -- 腐臭吞噬者
            262313, -- Malodorous Miasma
            262314, -- Putrid Paroxysm
            262292, -- Rotting Regurgitation
        },
        [2169] = { -- 泽克沃兹，恩佐斯的传令官
            265360, -- Roiling Deceit
            265662, -- Corruptor's Pact
            265237, -- Shatter
            265264, -- Void Lash
            265646, -- Will of the Corruptor
            264210, -- Jagged Mandible
            270589, -- Void Wail
            270620, -- Psionic Blast
        },
        [2166] = { -- 维克提斯
            265129, -- Omega Vector
            265178, -- Evolving Affliction
            265212, -- Gestate
            265127, -- Lingering Infection
            265206, -- Immunosuppression
        },
        [2195] = { -- 重生者祖尔
            273365, -- Dark Revelation
            274358, -- Rupturing Blood
            273434, -- Pit of Despair
            274195, -- Corrupted Blood
            274271, -- Deathwish
            272018, -- Absorbed in Darkness
            276020, -- Fixate
            276299, -- Engorged Burst
        },
        [2194] = { -- 拆解者米斯拉克斯
            272336, -- Annihilation
            272536, -- Imminent Ruin
            274693, -- Essence Shear
            272407, -- Oblivion Sphere
            272146, -- Annihilation
            274019, -- Mind Flay
            274113, -- Obliteration Beam
            274761, -- Oblivion Veil
            279013, -- Essence Shatter
        },
        [2147] = { -- 戈霍恩
            263334, -- Putrid Blood
            263372, -- Power Matrix
            263436, -- Imperfect Physiology
            272506, -- Explosive Corruption
            267409, -- Dark Bargain
            267430, -- Torment
            263235, -- Blood Feast
            270287, -- Blighted Ground
            263321, -- Undulating Mass
            267659, -- Unclean Contagion
            267700, -- Gaze of G'huun
            267813, -- Blood Host
            269691, -- Mind Thrall
            277007, -- Bursting Boil
            279575, -- Choking Miasma
        },
    },

    [1176] = { -- 达萨罗之战
        [2333] = { -- 圣光勇士
            283572, -- Sacred Blade
            283651, -- Blinding Faith
            283579, -- Consecration
        },
        [2325] = { -- 丛林之王格洛恩
            285875, -- Rending Bite
            283069, -- Megatomic Fire (Horde)
            286373, -- Chill of Death (Alliance)
            282215, -- Megatomic Seeker Missile
            282471, -- Voodoo Blast
            285659, -- Apetagonizer Core
            286434, -- Necrotic Core
            285671, -- Crushed
            282010, -- Shattered
        },
        [2341] = { -- 玉火大师
            286988, -- Searing Embers
            282037, -- Rising Flames
            288151, -- Tested
            285632, -- Stalking
        },
        [2342] = { -- 丰灵
            283063, -- Flames of Punishment
            283507, -- Volatile Charge
            286501, -- Creeping Blaze
            287072, -- Liquid Gold
            284470, -- Hex of Lethargy
        },
        [2330] = { -- 神选者教团
            284663, -- Bwonsamdi's Wrath
            282135, -- Crawling Hex
            285878, -- Mind Wipe
            282592, -- Bleeding Wounds
            286060, -- Cry of the Fallen
            282444, -- Lacerating Claws
            286811, -- Akunda's Wrath
            282209, -- Mark of Prey
        },
        [2335] = { -- 拉斯塔哈大王
            285195, -- Deadly Withering
            285044, -- Toad Toxin
            284831, -- Scorching Detonation
            284781, -- Grevious Axe
            285213, -- Caress of Death
            288449, -- Death's Door
            284662, -- Seal of Purification
            285349, -- Plague of Fire
        },
        [2334] = { -- 大工匠梅卡托克
            287167, -- Discombobulation
            283411, -- Gigavolt Blast
            286480, -- Anti Tampering Shock
            287757, -- Gigavolt Charge
            282182, -- Buster Cannon
            284168, -- Shrunk
            284214, -- Trample
            287891, -- Sheep Shrapnel
            289023, -- Enormous
        },
        [2337] = { -- 风暴之墙阻击战
            285000, -- Kelp Wrapping
            284405, -- Tempting Song
            285350, -- Storms Wail
            285075, -- Freezing Tidepool
            285382, -- Kelp Wrapping
        },
        [2343] = { -- 吉安娜·普罗德摩尔
            287626, -- Grasp of Frost
            287490, -- Frozen Solid
            287365, -- Searing Pitch
            285212, -- Chilling Touch
            285253, -- Ice Shard
            287199, -- Ring of Ice
            288218, -- Broadside
            289220, -- Heart of Frost
            288038, -- Marked Target
            287565, -- Avalanche
        },
    },

    [1177] = { -- 风暴熔炉
        [2328] = { -- 无眠秘党
            282540, -- Agent of demise
            282432, -- Crushing Doubt
            282384, -- Shear Mind
            283524, -- Aphotic Blast
            282517, -- Terrifying Echo
            282562, -- Promises of Power
            282738, -- Embrace of the void
            293300, -- Storm essence
            293488, -- Oceanic Essence
        },
        [2332] = { -- 乌纳特，虚空先驱
            285345, -- Maddening eyes of N'zoth
            285652, -- Insatiable torment
            284733, -- Embrace of the void
            285367  -- Piercing gaze
        },
    },

    [1179] = { -- 永恒王宫
        [2352] = { -- 深渊指挥官西瓦拉
            300882, -- Inversion Sickness
            295421, -- Over flowing Venom
            295348, -- Over flowing Chill
            294715, -- Toxic Brand
            294711, -- Frost Mark
            300705, -- Septic Taint
            300701, -- Rimefrost
            294847, -- Unstable Mixture
            300961, -- Frozen Ground
            300962, -- Septic Ground
        },
        [2347] = { -- 黑水巨鳗
            292127, -- Darkest Depths
            292307, -- Gaze from Below
            292167, -- Toxic Spine
            301494, -- Piercing Barb
            298595, -- Glowing Stinger
            292138, -- Radiant Biomass
            292133, -- Bioluminescence
        },
        [2353] = { -- 艾萨拉之辉
            296737, -- Arcane Bomb
            296566, -- Tide Fist
        },
        [2354] = { -- 艾什凡女勋爵
            296693, -- Waterlogged
            297333, -- Briny Bubble
            296725, -- Barnacle Bash
            296752, -- Cutting Coral
        },
        [2351] = { -- 奥戈佐亚
            298306, -- Incubation Fluid
            295779, -- Aqua Lance
            298156, -- Desensitizing Sting
        },
        [2359] = { -- 女王法庭
            297586, -- Suffering
            299914, -- Frenetic Charge
            296851, -- Fanatical Verdict
            300545, -- Mighty Rupture
        },
        [2349] = { -- 扎库尔，尼奥罗萨先驱
            292971, -- Hysteria
            292963, -- Dread
            293509, -- Manifest Nightmares
            298192, -- Dark Beyond
        },
        [2361] = { -- 艾萨拉女王
            303825, -- Crushing Depths
            303657, -- Arcane Burst
            300492, -- Static Shock
            297907, -- Cursed Heart
        },
    },

    [1180] = { -- 尼奥罗萨，觉醒之城
        [2368] = { -- 黑龙帝王拉希奥
            306163, -- Incineration
            314347, -- Noxxious Choke
            307013, -- Burning Madness
            313250, -- Creeping Madness (mythic)
        },
        [2365] = { -- 玛乌特
            307806, -- Devour Magic
            306301, -- Forbidden Mana
            307399, -- Shadow Wounds
            314992, -- Drain Essence
            314337, -- Ancient Curse (mythic)
        },
        [2369] = { -- 先知斯基特拉
            308059, -- Shadow Shock Applied
            307950, -- Shred Psyche
        },
        [2377] = { -- 黑暗审判官夏奈什
            313198, -- Void Touched
            312406, -- Voidwoken
        },
        [2372] = { -- 主脑
            313461, -- Corrosion
            313129, -- Mindless
            313460, -- Nullification
        },
        [2367] = { -- 无厌者夏德哈
            307358, -- Debilitating Spit
            307945, -- Umbral Eruption
            306929, -- Bubbling Breath
            307260, -- Fixate
            312332, -- Slimy Residue
            306930, -- Entropic Breath
        },
        [2373] = { -- 德雷阿佳丝
            310552, -- Mind Flay
            310358, -- Muttering Insanity
        },
        [2374] = { -- 伊格诺斯，重生之蚀
            275269, -- Fixate
            311159, -- Cursed Blood
        },
        [2370] = { -- 维克修娜
            307314, -- Encroaching Shadows
            307359, -- Despair
            310323, -- Desolation
        },
        [2364] = { -- 虚无者莱登
            306819, -- Nullifying Strike
            306273, -- Unstable Vita
            306279, -- Instability Exposure
            309777, -- Void Defilement
            313227, -- Decaying Wound
            310019, -- Charged Bonds
            313077, -- Unstable Nightmare
            315252, -- Dread Inferno Fixate
            316065, -- Corrupted Existence
        },
        [2366] = { -- 恩佐斯的外壳
            307008, -- Breed Madness
            306973, -- Madness Bomb
            306984, -- Insanity Bomb
            307008, -- Breed Madness
        },
        [2375] = { -- 腐蚀者恩佐斯
            308885, -- Mind Flay
            317112, -- Evoke Anguish
            309980, -- Paranoia
        },
    },

    [1023] = { -- 围攻伯拉勒斯
        ["general"] = {
            272571, -- 窒息之水
            257069, -- 防水甲壳
            257169, -- 恐惧咆哮
            454437, -- 艾泽里特炸药
            256709, -- 钢刃之歌
            257168, -- 诅咒挥砍
            272588, -- 腐烂伤口
            454440, -- 恶臭喷吐
            275836, -- 钉刺之毒
            274942, -- 香蕉狂怒
            256663, -- 燃烧沥青
            272140, -- 钢铁弹幕
            277432, -- 钢铁箭雨
            272144, -- 掩护
            -256616, -- 碎牙者（降低急速）
        },
        [2654] = { -- “屠夫”血钩
            257459, -- 上钩了
            257292, -- 沉重挥砍
        },
        [2173] = { -- 恐怖船长洛克伍德
            463182, -- 炽烈弹射
            256076, -- 一枪毙命
            268230, -- 腥红横扫
            272421, -- 瞄准火炮
        },
        [2134] = { -- 哈达尔·黑渊
            257886, -- 盐水池
        },
        [2140] = { -- 维克戈斯
            275014, -- 腐败之水
            270624, -- 窒息勒压
        },
    },

    [1022] = { -- 地渊孢林
        ["general"] = {
            265533, -- 鲜血之喉
            265019, -- 狂野顺劈斩
            265377, -- 抓钩诱捕
            265568, -- 黑暗预兆
            266107, -- 嗜血成性
            266265, -- 邪恶拥抱
            272180, -- 虚空喷吐
            265468, -- 枯萎诅咒
            272609, -- 疯狂凝视
            265511, -- 灵魂抽取
            278961, -- 衰落意志
            273599, -- 腐败之息
        },
        [2157] = { -- 长者莉娅克萨
            260685, -- 戈霍恩之蚀
        },
        [2131] = { -- 被感染的岩喉
            260333, -- 发脾气
            260455, -- 锯齿利牙
        },
        [2130] = { -- 孢子召唤师赞查
            259714, -- 腐烂孢子
            259718, -- 颠覆
            273226, -- 腐烂孢子
        },
        [2158] = { -- 不羁畸变怪
            269301, -- 腐败之血
        },
    },

    [1030] = { -- 塞塔里斯神庙
        ["general"] = {
            273563, -- 神经毒素
            272657, -- 毒性吐息
            272655, -- 黄沙冲刷
            272696, -- 瓶中闪电
            272699, -- 毒性喷吐
            268013, -- 烈焰震击
            268007, -- 心脏打击
            268008, -- 毒蛇诱惑
        },
        [2142] = { -- 阿德里斯和阿斯匹克斯
            263371, -- 导电
            263234, -- 弧光斩击
            268993, -- 偷袭
            263778, -- 狂风之力
            225080, -- 复生
        },
        [2143] = { -- 米利克萨
            267027, -- 细胞毒素
            263958, -- 缠绕的蛇群
            261732, -- 盲目之沙
            263927, -- 剧毒之池
        },
        [2144] = { -- 加瓦兹特
            266512, -- 放电
            266923, -- 充电
        },
        [2145] = { -- 塞塔里斯的化身
            269686, -- 瘟疫
            269670, -- 强化
            268024, -- 脉冲
        },
    },

    [1002] = { -- 托尔达戈
        ["general"] = {
            258864, -- 火力压制
            258313, -- 手铐
            258079, -- 巨口噬咬
            258075, -- 瘙痒叮咬
            258058, -- 挤压
            265889, -- 火把攻击
            258128, -- 衰弱怒吼
            225080, -- 复生
        },
        [2097] = { -- 泥沙女王
            257092, -- 流沙陷阱
            260016, -- 瘙痒叮咬
        },
        [2098] = { -- 杰斯·豪里斯
            257791, -- 咆哮恐惧
            257777, -- 断筋剃刀
            257793, -- 烟雾弹
            260067, -- 恶毒槌击
        },
        [2099] = { -- 骑士队长瓦莱莉
            257028, -- 点火器
            259711, -- 全面禁闭
        },
        [2096] = { -- 科古斯狱长
            256198, -- 艾泽里特子弹：爆炎弹
            256038, -- 致命狙击
            256044, -- 致命狙击
            256200, -- 竭心毒剂
            256105, -- 爆炸
            256201, -- 爆炎弹
        },
    },

    [1012] = { -- 暴富矿区！！
        ["general"] = {
            280604, -- 冰镇汽水
            280605, -- 脑部冻结
            263637, -- 晾衣绳
            269298, -- 寡妇蛛毒素
            263202, -- 石枪
            268704, -- 狂怒地震
            268846, -- 回声之刃
            263074, -- 溃烂撕咬
            262270, -- 腐蚀性化合物
            262794, -- 能量鞭笞
            262811, -- 吸血球
            268797, -- 转化：敌人变黏液
            269429, -- 充能射击
            262377, -- 搜寻并摧毁
            262348, -- 地雷爆炸
            269092, -- 炮弹弹幕
            262515, -- 艾泽里特觅心者
            262513, -- 艾泽里特觅心者
        },
        [2109] = { -- 投币式群体打击者
            256137, -- 定时爆炸
            257333, -- 电击之爪
            262347, -- 静电脉冲
            270882, -- 炽燃的艾泽里特
        },
        [2114] = { -- 艾泽洛克
            257582, -- 愤怒凝视
            258627, -- 地震回荡
            257544, -- 锯齿切割
            275907, -- 地质冲击
        },
        [2115] = { -- 瑞克莎·流火
            258971, -- 艾泽里特催化剂
            259940, -- 推进器冲击
            259853, -- 化学灼烧
        },
        [2116] = { -- 商业大亨拉兹敦克
            260811, -- 自控导弹
            260829, -- 自控导弹
            260838, -- 自控导弹
            270277, -- 大型红色火箭
        },
    },

    [1021] = { -- 维克雷斯庄园
        ["general"] = {
            263905, -- 符文劈斩
            265352, -- 蟾蜍疫病
            266036, -- 吸取精华
            264105, -- 符文印记
            264390, -- 法术禁锢
            265346, -- 苍白注视
            264050, -- 被感染的荆棘
            265761, -- 荆棘弹幕
            264153, -- 喷吐
            265407, -- 用餐时间
            271178, -- 掠食之跃
            263943, -- 蚀刻
            264520, -- 切裂蛇斩
            265881, -- 腐烂之触
            264378, -- 碎裂灵魂
            264407, -- 恐惧面容
            265880, -- 恐惧印记
            265882, -- 萦绕恐惧
            266035, -- 碎骨片
            263891, -- 缠绕荆棘
            264556, -- 刺裂打击
            278456, -- 感染
            264040, -- 荆棘树根
        },
        [2125] = { -- 毒心三姝
            260741, -- 锯齿荨麻
            260926, -- 灵魂操控
            260703, -- 不稳定的符文印记
            268086, -- 恐怖光环
        },
        [2126] = { -- 魂缚巨像
            260551, -- 灵魂荆棘
        },
        [2127] = { -- 贪食的拉尔
            268231, -- 腐物喷发
            426590, -- 贪食胆汁
        },
        [2128] = { -- 维克雷斯勋爵和夫人
            261439, -- 恶性病原体
            261438, -- 污秽攻击
            261440, -- 恶性病原体
        },
        [2129] = { -- 高莱克·图尔
            268203, -- 死亡棱镜
        },
    },

    [1001] = { -- 自由镇
        ["general"] = {
            257908, -- 浸油之刃
            257478, -- 减速撕咬
            274384, -- 捕鼠陷阱
            258323, -- 感染之伤
            257739, -- 盲目怒火
            257775, -- 瘟疫步

        },
        [2102] = { -- 天空上尉库拉格
            278993, -- 污秽轰炸
            256106, -- 艾泽里特填装弹
        },
        [2093] = { -- 海盗议会
            258874, -- 眩晕酒桶
            267523, -- 刀刃疾突
            1604,   -- 眩晕
            258352, -- 葡萄弹
        },
        [2094] = { -- 藏宝竞技场
            256553, -- 扭动的鲨鱼
            256363, -- 裂伤拳
            268283, -- 视线受阻
        },
        [2095] = { -- 哈兰·斯威提
            281591, -- 火炮弹幕
            257460, -- 燃烧残片
            257314, -- 黑火药炸弹
            413131, -- 回旋锋匕
        },
    },

    [1041] = { -- 诸王之眠
        [2165] = { -- 黄金风蛇
            265773, -- 吐金
            265914, -- 熔化的黄金
        },
        [2171] = { -- 殓尸者姆沁巴
            267626, -- 干枯
            267702, -- 埋葬
            267764, -- 挣扎
            267639, -- 燃烧腐蚀
        },
        [2170] = { -- 部族议会
            267273, -- 毒性新星
            266238, -- 粉碎防御
            266231, -- 斩首之斧
            267257, -- 雷鸣冲坠
        },
        [2172] = { -- 始皇达萨
            268932, -- 震地之跃
            268586, -- 剑刃连击
        },
    },

    [968] = { -- 阿塔达萨
        ["general"] = {
            253562, -- 野火
            254959, -- 灵魂燃烧
            260668, -- 鲜血灌注
            255567, -- 狂暴冲锋
            252781, -- 不稳定的妖术
            252692, -- 伏击之刺
            252687, -- 毒牙攻击
            255041, -- 惊骇尖啸
            255814, -- 撕裂重殴
        },
        [2082] = { -- 女祭司阿伦扎
            274195, -- 堕落之血
            277072, -- 腐化的黄金
            265914, -- 熔化的黄金
            255835, -- 鲜血灌注
            255836, -- 鲜血灌注
        },
        [2036] = { -- 沃卡尔
            263927, -- 剧毒之池
            250372, -- 挥之不去的恶心感
            255620, -- 脓疮爆发
        },
        [2083] = { -- 莱赞
            255434, -- 锯齿
            255371, -- 恐惧之面
            257407, -- 追踪
            255421, -- 吞噬
        },
        [2030] = { -- 亚兹玛
            250096, -- 毁灭痛苦
            259145, -- 碎魂
            249919, -- 刺穿
        },
    },

    [1036] = { -- 风暴神殿
        ["general"] = {
            268233, -- 电化震击
            274633, -- 碎甲重击
            268309, -- 无尽黑暗
            268315, -- 鞭笞
            268317, -- 撕裂大脑
            268322, -- 溺毙者之触
            268391, -- 心智突袭
            274720, -- 深渊打击
            276268, -- 沉重打击
            268059, -- 束缚之锚
            268027, -- 涨潮
            268214, -- 割肉
        },
        [2153] = { -- 阿库希尔
            264560, -- 窒息海潮
            264477, -- 深海之握
        },
        [2154] = { -- 海贤议会
            267899, -- 妨害劈斩
            267818, -- 切割冲击
        },
        [2155] = { -- 斯托颂勋爵
            268896, -- 心灵撕裂
            269104, -- 爆炸虚空
            269131, -- 上古摧心者
        },
        [2156] = { -- 低语者沃尔兹斯
            267034, -- 力量的低语
        },
    },

    [1178] = { -- 麦卡贡行动
        ["general"] = {
            299572, -- 缩小
            300764, -- 粘液箭
            300659, -- 吞噬软泥
            294180, -- 反抗烈焰
            299438, -- 无情铁锤
            300207, -- 震击线圈
            299475, -- 音速咆哮
            301712, -- 突袭
            299502, -- 纳米切割者
            294290, -- 处理废料
            294195, -- 电弧波动炮
            293986, -- 声波脉冲
        },
        [2357] = { -- 戈巴马克国王
            297257, -- 电荷充能
            297283, -- 落石
        },
        [2358] = { -- 冈克
            298124, -- 束缚粘液
        },
        [2360] = { -- 崔克茜和耐诺
            298669, -- 跳电
            298718, -- 超能跳电
            298602, -- 烟云
        },
        [2355] = { -- HK-8型空中压制单位
            302274, -- 爆裂冲击
            295939, -- 歼灭射线
            296150, -- 喷涌冲击
            295445, -- 毁灭
            296560, -- 附着静电
        },
        [2336] = { -- 坦克大战
            282943, -- 液压碾锤
            285388, -- 烈焰喷射
        },
        [2339] = { -- 狂犬K.U.-J.0.
            291972, -- 爆燃之跃
            294929, -- 烈焰撕咬
            291946, -- 喷射烈焰
        },
        [2348] = { -- 机械师的花园
            285460, -- 脉冲榴弹
            285443, -- “隐秘”烈焰火炮
            294860, -- 电荷绽放
        },
        [2331] = { -- 麦卡贡国王
            291928, -- 超荷电磁炮
            291914, -- 切割光线
        },
    },
}

F:LoadBuiltInDebuffs(debuffs)