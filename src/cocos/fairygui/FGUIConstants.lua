fgui.UIEventType  ={
    Enter = 0,
    Exit = 1,
    Changed = 2,
    Submit = 3,

    TouchBegin = 10,
    TouchMove = 11,
    TouchEnd = 12,
    Click = 13,
    RollOver = 14,
    RollOut = 15,
    MouseWheel = 16,
    RightClick = 17,
    MiddleClick = 18,

    PositionChange = 20,
    SizeChange = 21,

    KeyDown = 30,
    KeyUp = 31,

    Scroll = 40,
    ScrollEnd = 41,
    PullDownRelease = 42,
    PullUpRelease = 43,

    ClickItem = 50,
    ClickLink = 51,
    ClickMenu = 52,
    RightClickItem = 53,
    
    DragStart = 60,
    DragMove = 61,
    DragEnd = 62,
    Drop = 63,

    GearStop = 70,
}  


fgui.PackageItemType = {
    IMAGE = 0,
    MOVIECLIP = 1,
    SOUND = 2,
    COMPONENT = 3,
    ATLAS = 4,
    FONT = 5,
    SWF = 6,
    MISC = 7,
    UNKNOWN = 8,
    SPINE = 9,
    DRAGONBONES = 10
}

fgui.ObjectType = {
    IMAGE = 0,
    MOVIECLIP = 1,
    SWF = 2,
    GRAPH = 3,
    LOADER = 4,
    GROUP = 5,
    TEXT = 6,
    RICHTEXT = 7,
    INPUTTEXT = 8,
    COMPONENT = 9,
    LIST = 10,
    LABEL = 11,
    BUTTON = 12,
    COMBOBOX = 13,
    PROGRESSBAR = 14,
    SLIDER = 15,
    SCROLLBAR = 16,
    TREE = 17,
    LOADER3D = 18
}

fgui.ButtonMode = {
    COMMON = 0,
    CHECK = 1,
    RADIO = 2
}

fgui.ChildrenRenderOrder = {
    ASCENT = 0,
    DESCENT = 1,
    ARCH = 2
}

fgui.OverflowType = {
    VISIBLE = 0,
    HIDDEN = 1,
    SCROLL = 2
}

fgui.ScrollType = {
    HORIZONTAL = 0,
    VERTICAL = 1,
    BOTH = 2
}

fgui.ScrollBarDisplayType = {
    DEFAULT = 0,
    VISIBLE = 1,
    AUTO = 2,
    HIDDEN = 3
}

fgui.LoaderFillType = {
    NONE = 0,
    SCALE = 1,
    SCALE_MATCH_HEIGHT = 2,
    SCALE_MATCH_WIDTH = 3,
    SCALE_FREE = 4,
    SCALE_NO_BORDER = 5
}

fgui.ProgressTitleType = {
    PERCENT = 0,
    VALUE_MAX = 1,
    VALUE = 2,
    MAX = 3
}

fgui.ListLayoutType = {
    SINGLE_COLUMN = 0,
    SINGLE_ROW = 1,
    FLOW_HORIZONTAL = 2,
    FLOW_VERTICAL = 3,
    PAGINATION = 4
}

fgui.ListSelectionMode = {
    SINGLE = 0,
    MULTIPLE = 1,
    MULTIPLE_SINGLECLICK = 2,
    NONE = 3
}

fgui.GroupLayoutType = {
    NONE = 0,
    HORIZONTAL = 1,
    VERTICAL = 2
}

fgui.PopupDirection = {
    AUTO = 0,
    UP = 1,
    DOWN = 2
}

fgui.AutoSizeType = {
    NONE = 0,
    BOTH = 1,
    HEIGHT = 2,
    SHRINK = 3
}

fgui.FlipType = {
    NONE = 0,
    HORIZONTAL = 1,
    VERTICAL = 2,
    BOTH = 3
}

fgui.TransitionActionType = {
    XY = 0,
    Size = 1,
    Scale = 2,
    Pivot = 3,
    Alpha = 4,
    Rotation = 5,
    Color = 6,
    Animation = 7,
    Visible = 8,
    Sound = 9,
    Transition = 10,
    Shake = 11,
    ColorFilter = 12,
    Skew = 13,
    Text = 14,
    Icon = 15,
    Unknown = 16
}

fgui.FillMethod = {
    None = 0,
    Horizontal = 1,
    Vertical = 2,
    Radial90 = 3,
    Radial180 = 4,
    Radial360 = 5
}

fgui.FillOrigin = {
    Top = 0,
    Bottom = 1,
    Left = 2,
    Right = 3
}

fgui.ObjectPropID = {
    Text = 0,
    Icon = 1,
    Color = 2,
    OutlineColor = 3,
    Playing = 4,
    Frame = 5,
    DeltaTime = 6,
    TimeScale = 7,
    FontSize = 8,
    Selected = 9
}

fgui.TweenPropType = {
    None = 0,
    X = 1,
    Y = 2,
    Position = 3,
    Width = 4,
    Height = 5,
    Size = 6,
    ScaleX = 7,
    ScaleY = 8,
    Scale = 9,
    Rotation = 10,
    Alpha = 11,
    Progress = 12
};

fgui.RelationType = 
{
    Left_Left = 0,
    Left_Center = 1,
    Left_Right = 2,
    Center_Center = 3,
    Right_Left = 4,
    Right_Center = 5,
    Right_Right = 6,

    Top_Top = 7,
    Top_Middle = 8,
    Top_Bottom = 9,
    Middle_Middle = 10,
    Bottom_Top = 11,
    Bottom_Middle = 12,
    Bottom_Bottom = 13,

    Width = 14,
    Height = 15,

    LeftExt_Left = 16,
    LeftExt_Right = 17,
    RightExt_Left = 18,
    RightExt_Right = 19,
    TopExt_Top = 20,
    TopExt_Bottom = 21,
    BottomExt_Top = 22,
    BottomExt_Bottom = 23,

    Size = 24
}
