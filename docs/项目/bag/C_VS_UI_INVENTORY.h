//-----------------------------------------------------------------------------
// class C_VS_UI_INVENTORY
//
// slayer/vampire inventory base class.
//
// - slayer/vampire inventory 공통의 interface를 정의한다. 
// - slayer에서 vampire로 바뀌거나 또는 그 반대일 때, 객체를 재생성하여
//   inventory는 초기화되지만, inventory의 item은 그대로 유지된다. interface상에서의
//   inventory는 item을 저장하고 있지 않다. 그래서 이 class를 base로 하는 것이다.
//-----------------------------------------------------------------------------
class C_VS_UI_INVENTORY : public Window, public Exec, public ButtonVisual
{
	//-----------
	// Data
	//-----------
public:
	enum 
	{ 
		GRID_X = 10, 
		GRID_Y = 6,
		GRID_UNIT_PIXEL_X = 30,
		GRID_UNIT_PIXEL_Y = 30,
	};

private:

protected:
	enum INVENTORY_SPK_INDEX
	{
		INVENTORY_WINDOW,
		INVENTORY_WINDOW_ALPHA,
		INVENTORY_ITEMBACK,
		INVENTORY_ITEMBACK_ALPHA,
		INVENTORY_WINDOW_BOTTOM,
	};

	enum EXEC_ID
	{
		MONEY_ID,
		DESC_ID,
//		BIKE_ID,
//		EXCHANGE_ID,
		
		HELP_ID,
		CLOSE_ID,
		ALPHA_ID,
	};

	ButtonGroup *				m_pC_button_group;

	bool						m_bl_shift, m_bl_set_load;;

	C_SPRITE_PACK *			m_pC_inventory_spk;
	Rect							m_grid_rect; // 전체 Grid rect.

	int							m_focus_grid_x, m_focus_grid_y;

	// 상속받는 class에서 반드시 set해줘야 한다.
	int							m_grid_start_offset_x, m_grid_start_offset_y;
	int							m_money_button_offset_x, m_money_button_offset_y;

	//------------
	// Method
	//------------
private:
	void	SetDebugStart();
	void	SetDebugEnd();
	void	WriteLogLine(int line);
	void	WindowEventReceiver(id_t event);
	bool	IsPixel(int _x, int _y);
	void	UnacquireMouseFocus();
	void	AcquireDisappear();
	void	AcquireMouseFocus();
//	void	CancelPushState();
	bool	AllMatchWindowPixel(int _x, int _y) const;
	bool	AnyMatchWindowPixel(int _x, int _y) const;

protected:
	bool	Click(int grid_start_x, int grid_start_y);
	void	Use();


public:
// TIMER
	static bool		Timer(bool reset = false);
	static DWORD						m_dw_millisec;

	static C_SPRITE_PACK *			m_pC_mine_progress_spk;
	enum MINE_PROGRESS_SPK_INDEX
	{
		INVENTORY_BAR_BACK,
		INVENTORY_BAR,
		SKILL_BAR_BACK,
		SKILL_BAR,
	};

	static int					m_mine_grid_x, m_mine_grid_y;

	C_VS_UI_INVENTORY();
	virtual ~C_VS_UI_INVENTORY();

	//지뢰설치
	bool	StartInstallMineProgress(int focus_grid_x, int focus_grid_y);
	bool	IsInstallMineProgress()		{ return gbl_mine_progress; }
	void	EndInstallMineProgress()	{ gbl_mine_progress = false; }
	//지뢰만들기
	bool	StartCreateMineProgress(int focus_grid_x, int focus_grid_y);
	bool	IsCreateMineProgress()		{ return gbl_mine_progress; }
	void	EndCreateMineProgress()	{ gbl_mine_progress = false; }
	//폭탄 만들기
	bool	StartCreateBombProgress(int focus_grid_x, int focus_grid_y);
	bool	IsCreateBombProgress()		{ return gbl_mine_progress; }
	void	EndCreateBombProgress()	{ gbl_mine_progress = false; }

	void	Start(bool bl_set_load = true);
	void	Finish();
	void	Show();
	bool	MouseControl(UINT message, int _x, int _y);
	void	KeyboardControl(UINT message, UINT key, long extra);

	void	CancelPushState() { m_pC_button_group->CancelPushState(); }
	void	ShowButtonWidget(C_VS_UI_EVENT_BUTTON * p_button);
	void	ShowButtonDescription(C_VS_UI_EVENT_BUTTON * p_button);
	void	Run(id_t id);

	void	ResetRect();
	bool	TestGridRect(int _x, int _y) const;
	int	GetFocusedItemGridX(const MItem * p_item);
	int	GetFocusedItemGridY(const MItem * p_item);
	int	GetFocusedItemGridH(const MItem * p_item);
	Rect	GetGridRect() const { return m_grid_rect; }
	
	int		GetFocusGridX() {return  m_focus_grid_x;}
	int		GetFocusGridY() {return  m_focus_grid_y;}

	static void	AutoMove( int grid_x, int grid_y );
	
};