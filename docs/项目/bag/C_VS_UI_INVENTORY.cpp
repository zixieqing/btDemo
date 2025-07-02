
int	C_VS_UI_INVENTORY::m_mine_grid_x = -1, C_VS_UI_INVENTORY::m_mine_grid_y = -1;
C_SPRITE_PACK *	C_VS_UI_INVENTORY::m_pC_mine_progress_spk = NULL;
DWORD	C_VS_UI_INVENTORY::m_dw_millisec;

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::C_VS_UI_INVENTORY
//
// Ref by viva for friend system
//-----------------------------------------------------------------------------
C_VS_UI_INVENTORY::C_VS_UI_INVENTORY()
{
	g_pTempItem = NULL;
	g_RegisterWindow(this);
	
	int	desc_button_offset_x, desc_button_offset_y;
	int	close_button_offset_x, close_button_offset_y;
	int	help_button_offset_x, help_button_offset_y;
	int alpha_button_offset_x, alpha_button_offset_y;
	
	m_pC_dialog_drop_money = NULL;
	
	m_bl_shift = false;
	m_bl_set_load = false;
	
	m_pC_button_group = new ButtonGroup(this);
	m_pC_mine_progress_spk = NULL;
	m_pC_inventory_spk = NULL;

	switch(g_eRaceInterface)
	{
	case RACE_SLAYER:
		m_pC_inventory_spk = new C_SPRITE_PACK(SPK_SLAYER_INVENTORY);
		m_pC_mine_progress_spk = new C_SPRITE_PACK(SPK_MINE_PROGRESS);
		

		m_grid_start_offset_x = 13;
		m_grid_start_offset_y = 25;
		m_money_button_offset_x = 90;
		m_money_button_offset_y = 204+10;
		desc_button_offset_x = 65;
		desc_button_offset_y = 204+10;
		close_button_offset_x = 294;
		close_button_offset_y = 204+10;
		help_button_offset_x = 40;
		help_button_offset_y = 204+10;
		alpha_button_offset_x = 20;
		alpha_button_offset_y = 204+10;
		
		Set(10, 128, m_pC_inventory_spk->GetWidth(INVENTORY_WINDOW), m_pC_inventory_spk->GetHeight(INVENTORY_WINDOW));
		break;

	case RACE_VAMPIRE:
		m_pC_inventory_spk = new C_SPRITE_PACK(SPK_VAMPIRE_INVENTORY);
		
		m_grid_start_offset_x = 17;
		m_grid_start_offset_y = 19;
		m_money_button_offset_x = 90;
		m_money_button_offset_y = 204;
		desc_button_offset_x = 65;
		desc_button_offset_y = 204;
		close_button_offset_x = 294;
		close_button_offset_y = 204;
		help_button_offset_x = 40;
		help_button_offset_y = 204;
		alpha_button_offset_x = 20;
		alpha_button_offset_y = 204;
		
		Set(10, 128, m_pC_inventory_spk->GetWidth(INVENTORY_WINDOW), m_pC_inventory_spk->GetHeight(INVENTORY_WINDOW)+m_pC_inventory_spk->GetHeight(INVENTORY_WINDOW_BOTTOM)-25);
		break;

	case RACE_OUSTERS:
		m_pC_inventory_spk = new C_SPRITE_PACK(SPK_OUSTERS_INVENTORY);
		
		m_grid_start_offset_x = 25;
		m_grid_start_offset_y = 35;
		m_money_button_offset_x = 103;
		m_money_button_offset_y = 224;
		desc_button_offset_x = 78;
		desc_button_offset_y = 224;
		close_button_offset_x = 307;
		close_button_offset_y = 224;
		help_button_offset_x = 53;
		help_button_offset_y = 224;
		alpha_button_offset_x = 33;
		alpha_button_offset_y = 224;
		
		Set(10, 128, m_pC_inventory_spk->GetWidth(INVENTORY_WINDOW), m_pC_inventory_spk->GetHeight(INVENTORY_WINDOW));
		break;		
	}

	if( m_pC_inventory_spk == NULL )
	{
		sprintf( g_szBugReportBuffer, "Inventory::InitError");
		gpC_base->SendMessage(UI_SEND_BUG_REPORT, __LINE__, 0, (void*)g_szBugReportBuffer);
	}
	
	m_pC_button_group->Add(new C_VS_UI_EVENT_BUTTON(m_money_button_offset_x, m_money_button_offset_y, gpC_global_resource->m_pC_assemble_box_button_spk->GetWidth(C_GLOBAL_RESOURCE::AB_BUTTON_MONEY), gpC_global_resource->m_pC_assemble_box_button_spk->GetHeight(C_GLOBAL_RESOURCE::AB_BUTTON_MONEY), MONEY_ID, this, C_GLOBAL_RESOURCE::AB_BUTTON_MONEY));
	m_pC_button_group->Add(new C_VS_UI_EVENT_BUTTON(desc_button_offset_x, desc_button_offset_y, gpC_global_resource->m_pC_assemble_box_button_spk->GetWidth(C_GLOBAL_RESOURCE::AB_BUTTON_DESC), gpC_global_resource->m_pC_assemble_box_button_spk->GetHeight(C_GLOBAL_RESOURCE::AB_BUTTON_DESC), DESC_ID, this, C_GLOBAL_RESOURCE::AB_BUTTON_DESC));
	m_pC_button_group->Add(new C_VS_UI_EVENT_BUTTON(help_button_offset_x, help_button_offset_y, gpC_global_resource->m_pC_assemble_box_button_spk->GetWidth(C_GLOBAL_RESOURCE::AB_BUTTON_QUESTION), gpC_global_resource->m_pC_assemble_box_button_spk->GetHeight(C_GLOBAL_RESOURCE::AB_BUTTON_QUESTION), HELP_ID, this, C_GLOBAL_RESOURCE::AB_BUTTON_QUESTION));
	m_pC_button_group->Add(new C_VS_UI_EVENT_BUTTON(close_button_offset_x, close_button_offset_y, gpC_global_resource->m_pC_assemble_box_button_spk->GetWidth(C_GLOBAL_RESOURCE::AB_BUTTON_X), gpC_global_resource->m_pC_assemble_box_button_spk->GetHeight(C_GLOBAL_RESOURCE::AB_BUTTON_X), CLOSE_ID, this, C_GLOBAL_RESOURCE::AB_BUTTON_X));
	m_pC_button_group->Add(new C_VS_UI_EVENT_BUTTON(alpha_button_offset_x, alpha_button_offset_y, gpC_global_resource->m_pC_assemble_box_button_spk->GetWidth(C_GLOBAL_RESOURCE::AB_BUTTON_ALPHA), gpC_global_resource->m_pC_assemble_box_button_spk->GetHeight(C_GLOBAL_RESOURCE::AB_BUTTON_ALPHA), ALPHA_ID, this, C_GLOBAL_RESOURCE::AB_BUTTON_ALPHA));
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::~C_VS_UI_INVENTORY
//
// 
//-----------------------------------------------------------------------------
C_VS_UI_INVENTORY::~C_VS_UI_INVENTORY()
{
	DeleteNew(gpC_dialog_confirm_change_sex);

	gpC_vs_ui_window_manager->SetAlpha(C_VS_UI_WINDOW_MANAGER::INVENTORY, GetAttributes()->alpha);
	
	if(m_bl_set_load)
	{
		gpC_vs_ui_window_manager->SetRect(C_VS_UI_WINDOW_MANAGER::INVENTORY, Rect(x, y, w, h));
	}
	
	g_UnregisterWindow(this);
	
	if(m_pC_mine_progress_spk != NULL)
		DeleteNew(m_pC_mine_progress_spk);
	if(m_pC_button_group != NULL)
		DeleteNew(m_pC_button_group);
	if(m_pC_inventory_spk != NULL)
		DeleteNew(m_pC_inventory_spk);
	//	DeleteNew(m_pC_backcolor_spk);
	//	DeleteNew(m_pC_etc_button_spk);
	
	if(m_pC_dialog_drop_money != NULL)
		DeleteNew(m_pC_dialog_drop_money);
}


void C_VS_UI_INVENTORY::AutoMove( int grid_x, int grid_y )
{
	MItem * p_item = g_pInventory->GetItem(grid_x, grid_y);
	if( p_item == NULL )
		return;

	if(gC_vs_ui.IsRunningStorage() && g_pStorage)
	{
		int current_storage = g_pStorage->GetCurrent();
		const int storage_size = g_pStorage->GetSize();
		const int storage_max = STORAGE_SLOT;
		
		int i, j;
		
		for(j = 0; j < storage_size; j++)
		{
			//	g_pStorage->SetCurrent(j);
			g_pStorage->SetCurrent(current_storage);
			
			if(p_item->IsPileItem())
			{
				for(i = 0; i < storage_max; i++)
				{
					const MItem *p_slot_item = g_pStorage->GetItem(i);
					
					// 슬롯에 머가 있는경우 아이템 종류가 같은지 보고, 쌓을수 있는가 보고 쌓는다.
					if(p_item->IsInsertToItem( p_slot_item ))
					{
						int total_number = p_slot_item->GetNumber()+p_item->GetNumber();
						int max_number = p_item->GetMaxNumber();
						if(total_number <= max_number)
						{
							g_pInventory->RemoveItem(grid_x, grid_y);
							
							// 이전에 있던 item에 추가될 수 있는 경우
							
							// 대상 Item과 들고 있는(추가할 Item)을 Client에서 알아야 한다.
							// 들고 있는 Item은 Client에서 access할 수 있으므로 대상 Item을 보낸다.
							// 클라이언트에서 픽업된 아이템을 참조하므로 먼저 픽업
							// 픽업할때의 인자는 아무거나 보내도 상관없다 바로 떨어뜨릴꺼니까
#ifdef _LIB
							gpC_base->SendMessage(UI_ITEM_PICKUP_FROM_INVENTORY,
								grid_x, grid_y,
								(MItem *)p_item);
//#else
//							int item_x = x+grid_start_x+p_item->GetGridX()*GRID_UNIT_PIXEL_X+(p_item->GetGridWidth()*GRID_UNIT_PIXEL_X)/2-gpC_item->GetWidth(p_item->GetInventoryFrameID())/2;
//							int item_y = y+grid_start_y+p_item->GetGridY()*GRID_UNIT_PIXEL_Y+(p_item->GetGridHeight()*GRID_UNIT_PIXEL_Y)/2-gpC_item->GetHeight(p_item->GetInventoryFrameID())/2;
//							
//							
//							gpC_base->SendMessage(UI_ITEM_PICKUP_FROM_INVENTORY,
//								MAKEDWORD(grid_x, grid_y),
//								MAKEDWORD(item_x, item_y),
//								(MItem *)p_item);
#endif
							gpC_base->SendMessage(UI_SELECT_STORAGE_SLOT, current_storage, i);
							
							return;
						}
					}	
				}
			}
			current_storage ++;
			if(current_storage >= storage_size)
				current_storage = 0;
		}
		for(j = 0; j < storage_size; j++)
		{
			//g_pStorage->SetCurrent(j);
			g_pStorage->SetCurrent(current_storage);
			
			for(i = 0; i < storage_max; i++)
			{
				const MItem *p_slot_item = g_pStorage->GetItem(i);
				
				// 슬랏이 비었으면 걍~ 넣는다
				if(p_slot_item == NULL)
				{
					g_pInventory->RemoveItem(grid_x, grid_y);
					
#ifdef _LIB
					gpC_base->SendMessage(UI_ITEM_PICKUP_FROM_INVENTORY,
						grid_x, grid_y,
						(MItem *)p_item);
//#else
//					int item_x = x+grid_start_x+p_item->GetGridX()*GRID_UNIT_PIXEL_X+(p_item->GetGridWidth()*GRID_UNIT_PIXEL_X)/2-gpC_item->GetWidth(p_item->GetInventoryFrameID())/2;
//					int item_y = y+grid_start_y+p_item->GetGridY()*GRID_UNIT_PIXEL_Y+(p_item->GetGridHeight()*GRID_UNIT_PIXEL_Y)/2-gpC_item->GetHeight(p_item->GetInventoryFrameID())/2;
//					
//					
//					gpC_base->SendMessage(UI_ITEM_PICKUP_FROM_INVENTORY,
//						MAKEDWORD(grid_x, grid_y),
//						MAKEDWORD(item_x, item_y),
//						(MItem *)p_item);
#endif
					
					gpC_base->SendMessage(UI_SELECT_STORAGE_SLOT, current_storage, i);
					
					return;
				}
			}
			current_storage ++;
			if(current_storage >= storage_size)
				current_storage = 0;
		}
		// Storage에 아이템을 넣을 공간이 없다면 여기까지 오게 되고, 그렇다면 원래의 스토리지를 선택
		g_pStorage->SetCurrent(current_storage);
	}	// 퀵슬랏에 들어갈 수 있는 아이템인가 보고 퀵슬랏이 있는가 본다.
	else if(p_item->IsQuickItem() == true && !p_item->IsGearItem() &&
		(
		(g_eRaceInterface == RACE_SLAYER && g_pQuickSlot != NULL) ||
		(g_eRaceInterface == RACE_OUSTERS && (g_pArmsBand1 != NULL || g_pArmsBand2 != NULL))
		)
		)
	{
		// 큇슬랏 개수만큼 넣을수 있는가 검사한다
		// 처음에 쌓을수 있는가를 알아보고 쌓을수 있는곳이 없으면 빈곳에 넣는다												
		int quick_slot_max=0;
		if( g_eRaceInterface == RACE_OUSTERS )
		{
			if( g_pArmsBand1 != NULL )
				quick_slot_max+=g_pArmsBand1->GetPocketNumber();
			if( g_pArmsBand2 != NULL )
				quick_slot_max+=g_pArmsBand2->GetPocketNumber();
		}
		else quick_slot_max = g_pQuickSlot->GetSize();
		
		if(p_item->IsPileItem())
		{
			for(int i = 0; i < quick_slot_max; i++)
			{
				MItem *p_slot_item = NULL;
				if( g_eRaceInterface == RACE_OUSTERS)
					p_slot_item = C_VS_UI_OUSTERS_QUICKITEM::GetItem( i );
				else
					p_slot_item = g_pQuickSlot->GetItem( i );
				//MItem *p_slot_item = g_pQuickSlot->GetItem(i);
				
				// 슬롯에 머가 있는경우 아이템 종류가 같은지 보고, 쌓을수 있는가 보고 쌓는다.
				if(p_item->IsInsertToItem( p_slot_item ))
				{
					int total_number = p_slot_item->GetNumber()+p_item->GetNumber();
					int max_number = p_item->GetMaxNumber();
					if(total_number <= max_number)
					{
						g_pInventory->RemoveItem(grid_x, grid_y);
						
						// 이전에 있던 item에 추가될 수 있는 경우
						
						// 대상 Item과 들고 있는(추가할 Item)을 Client에서 알아야 한다.
						// 들고 있는 Item은 Client에서 access할 수 있으므로 대상 Item을 보낸다.
						// 클라이언트에서 픽업된 아이템을 참조하므로 먼저 픽업
						// 픽업할때의 인자는 아무거나 보내도 상관없다 바로 떨어뜨릴꺼니까
#ifdef _LIB
						gpC_base->SendMessage(UI_ITEM_PICKUP_FROM_INVENTORY,
							grid_x, grid_y,
							(MItem *)p_item);
//#else
//						int item_x = x+grid_start_x+p_item->GetGridX()*GRID_UNIT_PIXEL_X+(p_item->GetGridWidth()*GRID_UNIT_PIXEL_X)/2-gpC_item->GetWidth(p_item->GetInventoryFrameID())/2;
//						int item_y = y+grid_start_y+p_item->GetGridY()*GRID_UNIT_PIXEL_Y+(p_item->GetGridHeight()*GRID_UNIT_PIXEL_Y)/2-gpC_item->GetHeight(p_item->GetInventoryFrameID())/2;
//						
//						
//						gpC_base->SendMessage(UI_ITEM_PICKUP_FROM_INVENTORY,
//							MAKEDWORD(grid_x, grid_y),
//							MAKEDWORD(item_x, item_y),
//							(MItem *)p_item);
#endif
						gpC_base->SendMessage(UI_ITEM_INSERT_FROM_QUICKSLOT,
							i, 0, (void *)p_slot_item); // 대상 Item
						
						return;
					}
				}	
			}
		}
		for(int i = 0; i < quick_slot_max; i++)
		{
			MItem *p_slot_item = NULL; //g_pQuickSlot->GetItem(i);
			
			if( g_eRaceInterface == RACE_OUSTERS )
				p_slot_item = C_VS_UI_OUSTERS_QUICKITEM::GetItem( i );
			else
				p_slot_item = g_pQuickSlot->GetItem( i );
			
			// 슬랏이 비었으면 걍~ 넣는다
			if(p_slot_item == NULL)
			{
				g_pInventory->RemoveItem(grid_x, grid_y);
				
#ifdef _LIB
				gpC_base->SendMessage(UI_ITEM_PICKUP_FROM_INVENTORY,
					grid_x, grid_y,
					(MItem *)p_item);
//#else
//				int item_x = x+grid_start_x+p_item->GetGridX()*GRID_UNIT_PIXEL_X+(p_item->GetGridWidth()*GRID_UNIT_PIXEL_X)/2-gpC_item->GetWidth(p_item->GetInventoryFrameID())/2;
//				int item_y = y+grid_start_y+p_item->GetGridY()*GRID_UNIT_PIXEL_Y+(p_item->GetGridHeight()*GRID_UNIT_PIXEL_Y)/2-gpC_item->GetHeight(p_item->GetInventoryFrameID())/2;
//				
//				
//				gpC_base->SendMessage(UI_ITEM_PICKUP_FROM_INVENTORY,
//					MAKEDWORD(grid_x, grid_y),
//					MAKEDWORD(item_x, item_y),
//					(MItem *)p_item);
#endif
				
				if( g_eRaceInterface == RACE_OUSTERS )
				{
					// 첫번째 암스밴드인거면
					if( g_pArmsBand1 != NULL && g_pArmsBand1->GetPocketNumber() > i )
					{
						if (g_pArmsBand1->CanReplaceItem(p_item, i, p_slot_item))
						{
							gpC_base->SendMessage(UI_ITEM_DROP_TO_QUICKSLOT,i); // 들고 있던 것을 보낸다.												
							return;
						}										
					} else
					{
						// 두번째 암스밴드인거면 
						if( g_pArmsBand1 != NULL )
						{
							if (g_pArmsBand2->CanReplaceItem(p_item, i - g_pArmsBand1->GetPocketNumber() , p_slot_item))
							{
								gpC_base->SendMessage(UI_ITEM_DROP_TO_QUICKSLOT,i); // 들고 있던 것을 보낸다.													
								return;
							}											
						} else
						{
							if (g_pArmsBand2->CanReplaceItem(p_item, i, p_slot_item))
							{
								gpC_base->SendMessage(UI_ITEM_DROP_TO_QUICKSLOT,i); // 들고 있던 것을 보낸다.													
								return;
							}											
						}
					}
					
				} else
				{
					if (g_pQuickSlot->CanReplaceItem(p_item, i, p_slot_item))
					{
						gpC_base->SendMessage(UI_ITEM_DROP_TO_QUICKSLOT,
							i); // 들고 있던 것을 보낸다.
						
						return;
					}
					else
					{
						return;
					}
				}
			}
		}
	}
	// 기어창에 들어갈 수 있는 아이템인가 보고 넣는다
	else if(p_item->IsGearItem() && gbl_gear_lock == false && gC_vs_ui.IsRunningGearWindow())
	{
		int slot_max = 0;
		
		// 슬롯개수 만큼 돌면서 아이템이 들어가나 본다.
		// 뱀파이어와 슬레이어의 슬롯 개수는 틀리므로 따로따로
		switch(g_eRaceInterface)
		{
		case RACE_SLAYER:
			slot_max = MSlayerGear::MAX_GEAR_SLAYER;
			break;
			
		case RACE_VAMPIRE:
			slot_max = MVampireGear::MAX_GEAR_VAMPIRE;
			break;
			
		case RACE_OUSTERS:
			slot_max = MOustersGear::MAX_GEAR_OUSTERS;
			break;							
		}						
		
		int add_slot = -1;
		MItem *pChangeItem = NULL;
		for(int i = 0; i < slot_max; i++)
		{
			MItem * p_slot_item = NULL;
			
			if (gC_vs_ui.CanReplaceItemInGear(p_item, i, p_slot_item))
			{
				add_slot = i;
				pChangeItem = p_slot_item;
				// 빈 곳이면 바로 넣어버리면 된다.
				// 빈 곳이 아니라면.. 다음걸 찾는다.
				if(p_slot_item == NULL)
				{
					break;
				}
			}
		}
		
		if(add_slot != -1)
		{
			// 딱걸렸다
			// 클라이언트에서 픽업된 아이템을 참조하므로 먼저 픽업
			// 픽업할때의 인자는 아무거나 보내도 상관없다 바로 떨어뜨릴꺼니까
			g_pInventory->RemoveItem(grid_x, grid_y);
#ifdef _LIB
			gpC_base->SendMessage(UI_ITEM_PICKUP_FROM_INVENTORY,
				grid_x, grid_y,
				(MItem *)p_item);
//#else
//			int item_x = x+grid_start_x+p_item->GetGridX()*GRID_UNIT_PIXEL_X+(p_item->GetGridWidth()*GRID_UNIT_PIXEL_X)/2-gpC_item->GetWidth(p_item->GetInventoryFrameID())/2;
//			int item_y = y+grid_start_y+p_item->GetGridY()*GRID_UNIT_PIXEL_Y+(p_item->GetGridHeight()*GRID_UNIT_PIXEL_Y)/2-gpC_item->GetHeight(p_item->GetInventoryFrameID())/2;
//			
//			
//			gpC_base->SendMessage(UI_ITEM_PICKUP_FROM_INVENTORY,
//				MAKEDWORD(grid_x, grid_y),
//				MAKEDWORD(item_x, item_y),
//				(MItem *)p_item);
#endif
			
			// 기어에 넣는다
			gpC_base->SendMessage(UI_ITEM_DROP_TO_GEAR, 
				add_slot, 
				0, 
				NULL);
			
			// 기어에 넣은 아이템이 벨트라면 벨트를 연다.
			if(p_item->GetItemClass() == ITEM_CLASS_BELT)
				gC_vs_ui.RunQuickItemSlot();
			
			return;
		}
	}
	#ifdef __TEST_SUB_INVENTORY__   // add by Coffee 2007-8-9 藤속관櫓관
	// sub inventory 로 이동 
	else if( //p_item->GetItemClass() != ITEM_CLASS_PET_ITEM && // 요건 담에 삭제
		!gC_vs_ui.IsRunningExchange() &&
		gC_vs_ui.IsRunningSubInventory() && p_item->GetItemClass() != ITEM_CLASS_SUB_INVENTORY)
	{

		// 추가될 수 없는 경우
		// 다음의 아이템은 멀티팩에 추가할 수 없다. by bezz
		ITEM_CLASS ItemClass = p_item->GetItemClass();
		TYPE_ITEMTYPE ItemType = p_item->GetItemType() ;
		if ( ( ItemClass == ITEM_CLASS_RELIC )								// 성물
			|| ( ItemClass == ITEM_CLASS_BLOOD_BIBLE )						// 피의 성서
			|| ( ItemClass == ITEM_CLASS_CASTLE_SYMBOL )					// 성 상징
			|| ( ItemClass == ITEM_CLASS_WAR_ITEM )							// 전쟁 아이템/ 드래곤 아이
			|| ( ItemClass == ITEM_CLASS_EVENT_ITEM && ItemType == 27 )		// 깃발

			// sjheon 2004.04.28 add
			|| ( ItemClass == ITEM_CLASS_EVENT_ETC && ItemType == 18 )		// 패밀리 코인
			|| ( ItemClass == ITEM_CLASS_EVENT_ITEM && (ItemType >= 32 && ItemType <= 36) )		// 풍선 머리띠 
			// sjheon 2004.04.28 add
							
			|| ( ItemClass == ITEM_CLASS_SWEEPER ) )						// 스위퍼
		{
			return ;
		}


		POINT point;
		MSubInventory* pSubInventoryItem = (MSubInventory*)gC_vs_ui.GetSubInventoryItem();
		if(NULL == pSubInventoryItem)
			return ;

		if(p_item != NULL && pSubInventoryItem->GetFitPosition(p_item, point))
		{
			g_pInventory->RemoveItem(grid_x, grid_y);

			gpC_base->SendMessage(UI_ITEM_PICKUP_FROM_INVENTORY,
								grid_x, grid_y,
								(MItem *)p_item);

			const MItem* p_cur_item = pSubInventoryItem->GetItem(point.x, point.y);
			
			// 총에 탄창을 끼우는 것과 같은 것이 insert item이다.
			// 위치가 완전히 일치할경우에만 추가한다.
			if (p_item->IsInsertToItem( p_cur_item ) && p_cur_item->GetGridX() == point.x && p_cur_item->GetGridY() == point.y)
			{
				// 이전에 있던 item에 추가될 수 있는 경우
				
				// 대상 Item과 들고 있는(추가할 Item)을 Client에서 알아야 한다.
				// 들고 있는 Item은 Client에서 access할 수 있으므로 대상 Item을 보낸다.
				gpC_base->SendMessage(UI_ITEM_INSERT_FROM_INVENTORY,
					point.x, point.y,
					(void *)p_cur_item); // 대상 Item
			}
			else
			{	
				// 추가될 수 없는 경우
				MItem* p_old_item  = NULL;
				
				if (pSubInventoryItem->CanReplaceItem(p_item,		// 추가할 item
					point.x, point.y,	// 추가할 위치 
					p_old_item))								// 원래있던 item
				{
						
					gpC_base->SendMessage(UI_ITEM_DROP_TO_INVENTORY_SUB, 
						point.x, point.y,
						p_item);
					
				}
			}
			
		}
	}
	#endif
}
//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::WindowEventReceiver
//
// 
//-----------------------------------------------------------------------------
void C_VS_UI_INVENTORY::WindowEventReceiver(id_t event)
{
	switch (event)
	{
	case EVENT_WINDOW_MOVE:
		ResetRect();
		break;
	}
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::Start
//
//
//-----------------------------------------------------------------------------
void C_VS_UI_INVENTORY::Start(bool bl_set_load)
{
	m_bl_set_load = bl_set_load;
	
	AttrAlpha(gpC_vs_ui_window_manager->IsAlpha(C_VS_UI_WINDOW_MANAGER::INVENTORY));
	
	if(bl_set_load)	
	{
		Rect &rect = gpC_vs_ui_window_manager->GetRect(C_VS_UI_WINDOW_MANAGER::INVENTORY);
		if(rect.w != -1)
		{
			x = rect.x;
			y = rect.y;
		}
	}

	// 2004, 5, 6 sobeit add start - 착용 아이템 도움말 
	static bool FirstOpened = true;

	if(FirstOpened == true)
	{
		gC_vs_ui.AddHelpMail(HELP_EVENT_EQUIP_ITEM);
		FirstOpened = false;
	}
	// 2004, 5, 6 sobeit add end - 착용 아이템 도움말 
	
	PI_Processor::Start();
	
	AttrPin(true);
	gpC_window_manager->AppearWindow(this);
	
	// init
	ResetRect();
	m_focus_grid_x = NOT_SELECTED;
	m_focus_grid_y = NOT_SELECTED;
}

void	C_VS_UI_INVENTORY::SetDebugStart()
{
	return;
	FILE *fp=fopen("IsnventoryLog.txt","wt");
	fprintf(fp,"InventoryLogStart");
	fclose(fp);
}

void	C_VS_UI_INVENTORY::WriteLogLine(int line)
{
	return;
	FILE *fp = fopen("InventoryLog.txt","at");
	fseek(fp,0,SEEK_END);
	fwrite(&line,sizeof(int),1,fp);
	fclose(fp);
}

void	C_VS_UI_INVENTORY::SetDebugEnd()
{
	return;
	FILE *fp = fopen("InventoryLog.txt","at");
	fseek(fp,0,SEEK_END);
	fprintf(fp,"InventoryLogEnd");
	fclose(fp);
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::Finish
//
// 
//-----------------------------------------------------------------------------
void C_VS_UI_INVENTORY::Finish()
{
	gpC_vs_ui_window_manager->SetAlpha(C_VS_UI_WINDOW_MANAGER::INVENTORY, GetAttributes()->alpha);
	
	if(m_bl_set_load)
	{
		gpC_vs_ui_window_manager->SetRect(C_VS_UI_WINDOW_MANAGER::INVENTORY, Rect(x, y, w, h));
	}
	
	PI_Processor::Finish();
	
	gpC_window_manager->DisappearWindow(this);
	if(gpC_mouse_pointer->IsCursorDescription())gpC_mouse_pointer->CursorDescriptionToggle();
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::IsPixel
//
// 
//-----------------------------------------------------------------------------
bool C_VS_UI_INVENTORY::IsPixel(int _x, int _y)
{
	if(Moving()) return true;
	
	return AnyMatchWindowPixel(_x, _y);
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::ShowButtonWidget
//
// 
//-----------------------------------------------------------------------------
void	C_VS_UI_INVENTORY::ShowButtonDescription(C_VS_UI_EVENT_BUTTON * p_button)
{
	const static char* m_inventory_button_string[7] = 
	{
		(*g_pGameStringTable)[UI_STRING_MESSAGE_THROW_MONEY].GetString(),
		(*g_pGameStringTable)[UI_STRING_MESSAGE_SHOW_ITEM_DESCRIPTION].GetString(),
		(*g_pGameStringTable)[UI_STRING_MESSAGE_SHOW_HELP_INVENTORY_WINDOW].GetString(),
		(*g_pGameStringTable)[UI_STRING_MESSAGE_CLOSE_INVENTORY_WINDOW].GetString(),
		(*g_pGameStringTable)[UI_STRING_MESSAGE_SHOW_ALPHA_WINDOW].GetString(),
		(*g_pGameStringTable)[UI_STRING_MESSAGE_DEPOSIT_MONEY].GetString(),
		(*g_pGameStringTable)[UI_STRING_MESSAGE_SHOW_NO_ALPHA_WINDOW].GetString(),		
	};

	if(gC_vs_ui.IsRunningStorage() && p_button->GetID() == MONEY_ID)
		g_descriptor_manager.Set(DID_INFO, p_button->x+x, p_button->y+y, (void *)m_inventory_button_string[5],0,0);
	else if(GetAttributes()->alpha && p_button->GetID() == ALPHA_ID)
		g_descriptor_manager.Set(DID_INFO, p_button->x+x, p_button->y+y, (void *)m_inventory_button_string[6],0,0);
	else
	{
		if( p_button->GetID() != MONEY_ID )	
			g_descriptor_manager.Set(DID_INFO, p_button->x+x, p_button->y+y, (void *)m_inventory_button_string[p_button->GetID()],0,0);
	}
}


//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::ShowButtonWidget
//
// 
//-----------------------------------------------------------------------------
void	C_VS_UI_INVENTORY::ShowButtonWidget(C_VS_UI_EVENT_BUTTON * p_button)
{		
	if( p_button->GetID() == MONEY_ID )
	{
		if( !gC_vs_ui.IsRunningStorage() )
		{
			gpC_global_resource->m_pC_assemble_box_button_spk->BltLockedDarkness(p_button->x+x, p_button->y+y, p_button->m_image_index,1);
			return;
		}			
	}
		
	if(p_button->GetID() == ALPHA_ID)
	{
		if(GetAttributes()->alpha)
			gpC_global_resource->m_pC_assemble_box_button_spk->BltLocked(p_button->x+x, p_button->y+y, C_GLOBAL_RESOURCE::AB_BUTTON_ALPHA);
		else
			gpC_global_resource->m_pC_assemble_box_button_spk->BltLocked(p_button->x+x, p_button->y+y, C_GLOBAL_RESOURCE::AB_BUTTON_ALPHA_PUSHED);
	}
	else
	{
		if(p_button->GetFocusState())
		{
			if(p_button->GetPressState())
				gpC_global_resource->m_pC_assemble_box_button_spk->BltLocked(p_button->x+x, p_button->y+y, p_button->m_image_index+C_GLOBAL_RESOURCE::AB_BUTTON_PUSHED_OFFSET);
			else
				gpC_global_resource->m_pC_assemble_box_button_spk->BltLocked(p_button->x+x, p_button->y+y, p_button->m_image_index+C_GLOBAL_RESOURCE::AB_BUTTON_HILIGHTED_OFFSET);
		}
		else
			gpC_global_resource->m_pC_assemble_box_button_spk->BltLocked(p_button->x+x, p_button->y+y, p_button->m_image_index);
	}	
}

//-----------------------------------------------------------------------------
// Run
//
// 
//-----------------------------------------------------------------------------
void C_VS_UI_INVENTORY::Run(id_t id)
{
	switch (id)
	{
	case DESC_ID:
		gpC_mouse_pointer->CursorDescriptionToggle();
		break;
		
	case MONEY_ID:
		// money button이 눌렸다.
		// 돈을 버린다.
		if(m_pC_dialog_drop_money)
			DeleteNew(m_pC_dialog_drop_money);
		
		if (g_pMoneyManager->GetMoney() > 0)
		{
			if (gC_vs_ui.IsRunningStorage())
			{
				m_pC_dialog_drop_money = new C_VS_UI_MONEY_DIALOG(x+m_money_button_offset_x, y+m_money_button_offset_y+gpC_global_resource->m_pC_assemble_box_button_spk->GetHeight(C_GLOBAL_RESOURCE::AB_BUTTON_MONEY), 2, 0, ExecF_DropMoney, DIALOG_OK|DIALOG_CANCEL, 10, 
					C_VS_UI_MONEY_DIALOG::MONEY_DEPOSIT);	// by sigi
				m_pC_dialog_drop_money->Start();
			}
			//else if (gC_vs_ui.IsRunningExchange())
			//{
			//	m_pC_dialog_drop_money = new C_VS_UI_MONEY_DIALOG(m_money_button_rect.x, m_money_button_rect.Down(), 1, 0, ExecF_DropMoney, DIALOG_OK|DIALOG_CANCEL, 10, 
			//																	C_VS_UI_MONEY_DIALOG::MONEY_EXCHANGE);
			//}
//			else
//			{
//				m_pC_dialog_drop_money = new C_VS_UI_MONEY_DIALOG(x+m_money_button_offset_x, y+m_money_button_offset_y+gpC_global_resource->m_pC_assemble_box_button_spk->GetHeight(C_GLOBAL_RESOURCE::AB_BUTTON_MONEY), 1, 0, ExecF_DropMoney, DIALOG_OK|DIALOG_CANCEL, 10, 
//					C_VS_UI_MONEY_DIALOG::MONEY_DROP);	// by sigi
//			}
		}
		break;
		
	case CLOSE_ID:
		// close button이 눌렸다.
		
		if (gbl_sell_running)
		{
			gpC_base->SendMessage(UI_ITEM_SELL_FINISHED);
		}
		else if (gbl_buy_running)
		{
			gpC_base->SendMessage(UI_CLOSE_SHOP);
		}
		else if (gbl_repair_running)
		{
			gpC_base->SendMessage(UI_ITEM_REPAIR_FINISHED);
		}
		else if (gbl_silvering_running)
		{
			gpC_base->SendMessage(UI_ITEM_SILVERING_FINISHED);
		}
		else if (gC_vs_ui.IsRunningStorage())
		{
			gpC_base->SendMessage(UI_CLOSE_STORAGE);
		}
		else if (gC_vs_ui.IsRunningPetStorage())
		{
			gpC_base->SendMessage(UI_CLOSE_PETSTORAGE);
		}
		// 2005, 1, 3, sobeit add start
		else if(gbl_swap_advancement_item_running)
		{
			gpC_base->SendMessage(UI_CLOSE_SWAPADVANCEMENTITEM);
		}
		// 2005, 1, 3, sobeit add end
		//else if (gC_vs_ui.IsRunningExchange())
		//{
		//	gpC_base->SendMessage(UI_CLOSE_EXCHANGE);
		//}
		else
		{
			gC_vs_ui.HotKey_Inventory();
		}
		break;
		
	case HELP_ID:
		gC_vs_ui.RunDescDialog(DID_HELP, (void *)C_VS_UI_DESC_DIALOG::INVENTORY);
		break;
		
	case ALPHA_ID:
		AttrAlpha(!GetAttributes()->alpha);
		EMPTY_MOVE;
		break;
	}
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::AnyMatchWindowPixel
//
// Window image의 pixel이 (x, y) 한 점이라도 일치하면 true를 아니면 false를 반환한다.
//
// Item을 들고 있을 때에는 'item 참조포인트'에 따라 진행한다.
//-----------------------------------------------------------------------------
bool C_VS_UI_INVENTORY::AnyMatchWindowPixel(int _x, int _y) const
{
	if (gpC_mouse_pointer->GetPickUpItem())
	{
		for (int i=0; i < ITEM_REF_POINT_COUNT; i++)
		{
			int px = g_item_ref_point[i].x+gpC_mouse_pointer->GetPointerX();
			int py = g_item_ref_point[i].y+gpC_mouse_pointer->GetPointerY();
			if (m_pC_inventory_spk->IsPixel(px-x, py-y))
				return true;
		}
		
		return false;
	}
	else
	{
		return m_pC_inventory_spk->IsPixel(_x-x, _y-y);
	}
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::AllMatchWindowPixel
//
//
//-----------------------------------------------------------------------------
bool C_VS_UI_INVENTORY::AllMatchWindowPixel(int _x, int _y) const
{
	if (gpC_mouse_pointer->GetPickUpItem())
	{ 
		for (int i=0; i < ITEM_REF_POINT_COUNT; i++)
		{
			int px = g_item_ref_point[i].x+gpC_mouse_pointer->GetPointerX();
			int py = g_item_ref_point[i].y+gpC_mouse_pointer->GetPointerY();
			if (m_pC_inventory_spk->IsPixel(px-x, py-y) == false)
				return false;
		}
		
		return true;
	}
	else
	{
		return m_pC_inventory_spk->IsPixel(_x-x, _y-y);
	}
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::TestGridRect
//
// Grid rect 위에 있으면 true, 아니면 false를 반환한다.
//-----------------------------------------------------------------------------
bool C_VS_UI_INVENTORY::TestGridRect(int _x, int _y) const
{
	return (m_grid_rect.IsInRect(_x, _y)// || 
		//			  m_money_button_rect.IsInRect(_x, _y) ||
		//			  m_desc_button_rect.IsInRect(_x, _y) ||
		//			  m_bike_button_rect.IsInRect(_x, _y) ||
		//			  m_close_button_rect.IsInRect(_x, _y) ||
		//			  m_help_button_rect.IsInRect(_x, _y)
		);
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::CancelPushState
//
// 
//-----------------------------------------------------------------------------
//void	C_VS_UI_INVENTORY::CancelPushState()
//{
//	m_bl_money_button_pushed = false;
//	m_bl_desc_button_pushed = false;
//	m_bl_bike_button_pushed = false;
//	m_bl_close_button_pushed = false;
//	m_bl_help_button_pushed = false;
//}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::AcquireMouseFocus
//
// 
//-----------------------------------------------------------------------------
void	C_VS_UI_INVENTORY::AcquireMouseFocus()
{
	gpC_base->SendMessage(UI_REMOVE_BACKGROUND_MOUSE_FOCUS);
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::AcquireDisappear
//
// 
//-----------------------------------------------------------------------------
void C_VS_UI_INVENTORY::AcquireDisappear()
{
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::UnacquireMouseFocus
//
// 
//-----------------------------------------------------------------------------
void C_VS_UI_INVENTORY::UnacquireMouseFocus()
{
	m_pC_button_group->UnacquireMouseFocus();
	m_focus_grid_x = NOT_SELECTED;
	m_focus_grid_y = NOT_SELECTED;
	
	//	m_bl_money_button_focused = false;
	//	m_bl_desc_button_focused = false;
	//	m_bl_bike_button_focused = false;
	//	m_bl_close_button_focused = false;
	//	m_bl_help_button_focused = false;
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::GetFocusedItemGridX
//
// 
//-----------------------------------------------------------------------------
int C_VS_UI_INVENTORY::GetFocusedItemGridX(const MItem * p_item)
{
	assert(p_item);
	
	if (p_item == NULL)
		return 0;
	
	return m_grid_rect.x+GRID_UNIT_PIXEL_X*p_item->GetGridX();
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::GetFocusedItemGridY
//
// 
//-----------------------------------------------------------------------------
int C_VS_UI_INVENTORY::GetFocusedItemGridY(const MItem * p_item)
{
	assert(p_item);
	
	if (p_item == NULL)
		return 0;
	
	return m_grid_rect.y+GRID_UNIT_PIXEL_Y*p_item->GetGridY();
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::GetFocusedItemGridH
//
// 
//-----------------------------------------------------------------------------
int C_VS_UI_INVENTORY::GetFocusedItemGridH(const MItem * p_item)
{
	assert(p_item);
	
	if (p_item == NULL)
		return 0;
	
	return GRID_UNIT_PIXEL_Y*p_item->GetGridHeight();
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::Show
//
// 
//-----------------------------------------------------------------------------
void C_VS_UI_INVENTORY::Show()
{	
	SetDebugStart();
	if (gpC_base->m_p_DDSurface_back->Lock())
	{				
		Rect rect;
		if( g_eRaceInterface == RACE_VAMPIRE )
			rect.Set(0, 0, w, h-m_pC_inventory_spk->GetHeight(INVENTORY_WINDOW_BOTTOM));
				
		if(GetAttributes()->alpha)
		{
			
			RECT alpha_rect;
			//슬레이어 인터페이스 알파는 창 구석부분 알파처리-_-;
			switch(g_eRaceInterface)
			{
				case RACE_SLAYER:
					// 위
					SetRect(&alpha_rect, x+10, y+12, x+315, y+21);
					DrawAlphaBox(&alpha_rect, 0, 2, 2, g_pUserOption->ALPHA_DEPTH);
					
					// 아래
					SetRect(&alpha_rect, x+5, y+209, x+321, y+245);
					DrawAlphaBox(&alpha_rect, 0, 2, 2, g_pUserOption->ALPHA_DEPTH);
					
					// 왼쪽
					SetRect(&alpha_rect, x+5, y+24, x+9, y+245);
					DrawAlphaBox(&alpha_rect, 0, 2, 2, g_pUserOption->ALPHA_DEPTH);
					
					// 오른쪽
					SetRect(&alpha_rect, x+317, y+24, x+321, y+245);
					DrawAlphaBox(&alpha_rect, 0, 2, 2, g_pUserOption->ALPHA_DEPTH);
					
				break;

				case RACE_OUSTERS:
					// 위
					SetRect(&alpha_rect, x+25, y+14, x+325, y+31);
					DrawAlphaBox(&alpha_rect, 0, 4, 0, g_pUserOption->ALPHA_DEPTH);
					
					// 아래
					SetRect(&alpha_rect, x+21, y+219, x+329, y+262);
					DrawAlphaBox(&alpha_rect, 0, 4, 0, g_pUserOption->ALPHA_DEPTH);
					
					// 왼쪽
					SetRect(&alpha_rect, x+16, y+24, x+21, y+245);
					DrawAlphaBox(&alpha_rect, 0, 4, 0, g_pUserOption->ALPHA_DEPTH);
					
					// 오른쪽
					SetRect(&alpha_rect, x+329, y+46, x+333, y+230);
					DrawAlphaBox(&alpha_rect, 0, 4, 0, g_pUserOption->ALPHA_DEPTH);
					
				break;
			}
			
			if(g_eRaceInterface == RACE_VAMPIRE)
				m_pC_inventory_spk->BltLockedClip(x, y, rect, INVENTORY_WINDOW_ALPHA);
			else
				m_pC_inventory_spk->BltLocked(x, y, INVENTORY_WINDOW_ALPHA);
		}
		else
		{
			switch(g_eRaceInterface)
			{
			case RACE_SLAYER:
				m_pC_inventory_spk->BltLocked(x, y, INVENTORY_WINDOW);
				
				break;

			case RACE_VAMPIRE:
				m_pC_inventory_spk->BltLockedClip(x, y, rect, INVENTORY_WINDOW);
				break;

			case RACE_OUSTERS:
				m_pC_inventory_spk->BltLocked(x, y, INVENTORY_WINDOW);
				break;					
			}				
		}

		if(g_eRaceInterface == RACE_VAMPIRE)
			// 뱀파이어 인터페이스는 하단 합체
			m_pC_inventory_spk->BltLocked(x, y+rect.h, INVENTORY_WINDOW_BOTTOM);
		
		
		gpC_global_resource->m_pC_assemble_box_button_spk->BltLocked(x+m_money_button_offset_x+25, y+m_money_button_offset_y, C_GLOBAL_RESOURCE::AB_MONEY_BAR);
		
		// show Item
		
		
		
		const MItem * p_selected_item = g_pInventory->GetItem(m_focus_grid_x, m_focus_grid_y);
		
		g_pInventory->SetBegin();
		bool bl_alpha[10][6];	// 커헉-_- 하드코딩 아이템 놓인곳은 다르게 표현해야 하니까.. 남은부분은 따로 처리
		ZeroMemory(bl_alpha, 10*6*sizeof(bool));
		WriteLogLine(__LINE__);
		while (g_pInventory->IsNotEnd())
		{
			
			MItem * p_item = g_pInventory->Get();
			
			
			// p_item은 NULL이 반드시 아니다. 왜냐하면 존재하는 것만 Get()하기 때문이다.
			assert(p_item);

			// frame id -> sprite id
			if(p_item)
			{
				TYPE_FRAMEID frame_id = p_item->GetInventoryFrameID();
				
				
				int item_x = x+GetFocusedItemGridX(p_item);
				
				int item_y = y+GetFocusedItemGridY(p_item);
				
				
				int alpha_r, alpha_g, alpha_b;
				switch(g_eRaceInterface)
				{
				case RACE_SLAYER:
					alpha_r = 5;
					alpha_g = 7;
					alpha_b = 7;
					break;

				case RACE_VAMPIRE:
					alpha_r = 7;
					alpha_g = 5;
					alpha_b = 5;
					break;

				case RACE_OUSTERS:
					alpha_r = 5;
					alpha_g = 7;
					alpha_b = 5;
					break;
				}				
				
				// Item이 놓여있는 영역 표시
				for (int j = 0; j < p_item->GetGridHeight(); j++)
				{
					for (int i = 0; i < p_item->GetGridWidth(); i++)
					{
						
						if(GetAttributes()->alpha)
						{
							
							RECT alpha_rect;
							alpha_rect.left = item_x+GRID_UNIT_PIXEL_X*i+1;
							alpha_rect.top = item_y+GRID_UNIT_PIXEL_Y*j+1;
							alpha_rect.right = alpha_rect.left+28;
							alpha_rect.bottom = alpha_rect.top+28;
							//							gpC_base->m_p_DDSurface_back->Unlock();
							DrawAlphaBox(&alpha_rect, alpha_r, alpha_g, alpha_b, g_pUserOption->ALPHA_DEPTH);
							
							//							gpC_base->m_p_DDSurface_back->Lock();
							
							bl_alpha[p_item->GetGridX()+i][p_item->GetGridY()+j] = true;
							
						}
						else
						{
							
							m_pC_inventory_spk->BltLocked(item_x+GRID_UNIT_PIXEL_X*i, 
								item_y+GRID_UNIT_PIXEL_Y*j,
								INVENTORY_ITEMBACK);
							
						}
					}
				}
					
				
				item_x += (p_item->GetGridWidth()*GRID_UNIT_PIXEL_X)/2-gpC_item->GetWidth(frame_id)/2;
				item_y += (p_item->GetGridHeight()*GRID_UNIT_PIXEL_Y)/2-gpC_item->GetHeight(frame_id)/2;
				
				
				// 크리스마스 트리용 하드코딩
				if(p_item->GetItemClass() == ITEM_CLASS_EVENT_TREE 
					&& p_item->GetItemType() != 12
					&& p_item->GetItemType() != 25
					&& p_item->GetItemType() != 26
					&& p_item->GetItemType() != 27
					&& p_item->GetItemType() != 28
					&& p_item->GetItemType() != 41
					&& p_item->GetItemType() < 42)
				{
					bool bTreeItem = false;
					int	 temp = 0;

					if(p_item->GetItemType() > 12 )
						temp = 13;

					if(p_item->GetItemType() >= 29 )
						temp = 29;
					
					MItem *pTreeItem = NULL;
				
					// 위쪽
					pTreeItem = g_pInventory->GetItem(p_item->GetGridX(), p_item->GetGridY()-1);
					if(pTreeItem != NULL &&
						pTreeItem->GetItemClass() == ITEM_CLASS_EVENT_TREE &&
						pTreeItem->GetItemType() == p_item->GetItemType()-3)
						bTreeItem = true;
					
					// 아래쪽
					pTreeItem = g_pInventory->GetItem(p_item->GetGridX(), p_item->GetGridY()+1);
					if(pTreeItem != NULL &&
						pTreeItem->GetItemClass() == ITEM_CLASS_EVENT_TREE &&
						pTreeItem->GetItemType() == p_item->GetItemType()+3)
						bTreeItem = true;
					
					// 왼쪽
					pTreeItem = g_pInventory->GetItem(p_item->GetGridX()-1, p_item->GetGridY());
					if(pTreeItem != NULL &&
						pTreeItem->GetItemClass() == ITEM_CLASS_EVENT_TREE &&
						pTreeItem->GetItemType() == p_item->GetItemType()-1 &&
						(p_item->GetItemType()-temp)%3 != 0)
						bTreeItem = true;
					
					// 오른쪽
					pTreeItem = g_pInventory->GetItem(p_item->GetGridX()+1, p_item->GetGridY());
					if(pTreeItem != NULL &&
						pTreeItem->GetItemClass() == ITEM_CLASS_EVENT_TREE &&
						pTreeItem->GetItemType() == p_item->GetItemType()+1 &&
						(p_item->GetItemType()-temp)%3 != 2)
						bTreeItem = true;

					if (p_selected_item && (p_selected_item->GetID() == p_item->GetID()))
					{
						gpC_item->BltLockedOutlineOnly(item_x, item_y, WHITE, frame_id);
						
					}
					
					

					if(bTreeItem)
					{
						gpC_item->BltLocked(item_x, item_y, frame_id);
						
					}
					else
					{
						gpC_item->BltLockedDarkness(item_x, item_y, frame_id, 1);
						
					}
					
				}
				else
				if (p_selected_item && (p_selected_item->GetID() == p_item->GetID()))
				{
					if(p_item->IsSpecialColorItem() )
						CIndexSprite::SetUsingColorSet(const_cast<MItem *>(p_item)->GetSpecialColorItemColorset(), 0);
					else			
						CIndexSprite::SetUsingColorSet(const_cast<MItem *>(p_item)->GetItemOptionColorSet(), 0);
					gpC_item->BltLockedOutline(item_x, item_y, WHITE, frame_id);
					if(p_item->GetItemClass() == ITEM_CLASS_OUSTERS_WRISTLET && g_eRaceInterface == RACE_OUSTERS)
					{
						ITEMTABLE_INFO::ELEMENTAL_TYPE eType = (*g_pItemTable)[p_item->GetItemClass()][p_item->GetItemType()].ElementalType;
						if(eType == ITEMTABLE_INFO::ELEMENTAL_TYPE_FIRE ||
							eType == ITEMTABLE_INFO::ELEMENTAL_TYPE_WATER ||
							eType == ITEMTABLE_INFO::ELEMENTAL_TYPE_EARTH
							)
						{
							gpC_global_resource->m_pC_info_spk->BltLockedOutline(x+GetFocusedItemGridX(p_item), y+GetFocusedItemGridY(p_item), RGB_WHITE, C_GLOBAL_RESOURCE::OUSTERS_ELEMENTAL_MARK_FIRE+eType);
							
						}
					}
					
				}
				else
				{
					if(p_item->GetPersnal() == true) 
						gpC_item->BltLockedOutlineOnly(item_x, item_y, DARKRED, frame_id);

//							gpC_item->BltLockedColorSet(item_x, item_y, frame_id, ITEM_DISABLE_COLOR_SET);
//						gpC_item->BltLockedOutlineOnly(item_x, item_y, DARKRED, frame_id);

						//gpC_item->BltLockedColor(item_x, item_y, frame_id, RGB(255,0,0));
					
						//gpC_item->BltLockedOutlineOnly(item_x, item_y, DARKRED, frame_id);
					
					if(p_item->IsSpecialColorItem() )
						CIndexSprite::SetUsingColorSet(const_cast<MItem *>(p_item)->GetSpecialColorItemColorset(), 0);
					else			
						CIndexSprite::SetUsingColorSet(const_cast<MItem *>(p_item)->GetItemOptionColorSet(), 0);
					
					
					if (p_item->IsAffectStatus() || p_item->IsQuestItem() )
					{
						// frame id -> sprite id
						gpC_item->BltLocked(item_x, item_y, frame_id);
						if(p_item->GetItemClass() == ITEM_CLASS_OUSTERS_WRISTLET && g_eRaceInterface == RACE_OUSTERS)
						{
							ITEMTABLE_INFO::ELEMENTAL_TYPE eType = (*g_pItemTable)[p_item->GetItemClass()][p_item->GetItemType()].ElementalType;
							if(eType == ITEMTABLE_INFO::ELEMENTAL_TYPE_FIRE ||
								eType == ITEMTABLE_INFO::ELEMENTAL_TYPE_WATER ||
								eType == ITEMTABLE_INFO::ELEMENTAL_TYPE_EARTH
								)
							{
								gpC_global_resource->m_pC_info_spk->BltLocked(x+GetFocusedItemGridX(p_item), y+GetFocusedItemGridY(p_item), C_GLOBAL_RESOURCE::OUSTERS_ELEMENTAL_MARK_FIRE+eType);
								
							}
						}
					}
					else
					{
						gpC_item->BltLockedColorSet(item_x, item_y, frame_id, ITEM_DISABLE_COLOR_SET);
						if(p_item->GetItemClass() == ITEM_CLASS_OUSTERS_WRISTLET && g_eRaceInterface == RACE_OUSTERS)
						{
							ITEMTABLE_INFO::ELEMENTAL_TYPE eType = (*g_pItemTable)[p_item->GetItemClass()][p_item->GetItemType()].ElementalType;
							if(eType == ITEMTABLE_INFO::ELEMENTAL_TYPE_FIRE ||
								eType == ITEMTABLE_INFO::ELEMENTAL_TYPE_WATER ||
								eType == ITEMTABLE_INFO::ELEMENTAL_TYPE_EARTH
								)
							{
								gpC_global_resource->m_pC_info_spk->BltLockedColor(x+GetFocusedItemGridX(p_item), y+GetFocusedItemGridY(p_item), C_GLOBAL_RESOURCE::OUSTERS_ELEMENTAL_MARK_FIRE+eType, 0);
								
							}
						}
					}

					if(p_item->GetPersnal() == true) 
						gpC_item->BltLockedDarkness(item_x, item_y, frame_id, 1);

				}
			}
			g_pInventory->Next();
		}
		
		if(GetAttributes()->alpha)
		{
			
			int alpha_r, alpha_g, alpha_b;
			switch(g_eRaceInterface)
			{
			case RACE_SLAYER:
				alpha_r = 0;
				alpha_g = 2;
				alpha_b = 2;
				break;

			case RACE_VAMPIRE:
				alpha_r = 2;
				alpha_g = 0;
				alpha_b = 0;
				break;

			case RACE_OUSTERS:
				alpha_r = 0;
				alpha_g = 2;
				alpha_b = 0;
				break;				
			}
			
			
			for(int alpha_x = 0; alpha_x < 10; alpha_x++)
			{
				for(int alpha_y = 0; alpha_y < 6; alpha_y++)
				{
					if(bl_alpha[alpha_x][alpha_y] == false)
					{
						RECT alpha_rect;
						alpha_rect.left = x+m_grid_rect.x+alpha_x*GRID_UNIT_PIXEL_X+1;
						alpha_rect.top = y+m_grid_rect.y+alpha_y*GRID_UNIT_PIXEL_Y+1;
						alpha_rect.right = alpha_rect.left+28;
						alpha_rect.bottom = alpha_rect.top+28;
						
						DrawAlphaBox(&alpha_rect, alpha_r, alpha_g, alpha_b, g_pUserOption->ALPHA_DEPTH);
					}
				}
			}
			
		}
		//
		// Item을 들고 있으면 grid 위치를 미리 알 수 있도록 한다.
		//
		if (gpC_mouse_pointer->GetPickUpItem() && 
			m_focus_grid_x != NOT_SELECTED && 
			m_focus_grid_y != NOT_SELECTED)
		{
			
			MItem * p_item = gpC_mouse_pointer->GetPickUpItem();
			
			TYPE_FRAMEID frame_id = p_item->GetInventoryFrameID();
			int item_x = x+m_grid_rect.x+GRID_UNIT_PIXEL_X*m_focus_grid_x+(p_item->GetGridWidth()*GRID_UNIT_PIXEL_X)/2-gpC_item->GetWidth(frame_id)/2;
			int item_y = y+m_grid_rect.y+GRID_UNIT_PIXEL_Y*m_focus_grid_y+(p_item->GetGridHeight()*GRID_UNIT_PIXEL_Y)/2-gpC_item->GetHeight(frame_id)/2;
			
			MItem * p_old_item;
			
			if (g_pInventory->CanReplaceItem(p_item, m_focus_grid_x, m_focus_grid_y, p_old_item))
			{
				if (p_old_item)
					gpC_item->BltLockedOutlineOnly(item_x, item_y, ga_item_blink_color_table[g_blink_value], frame_id);
				else
					
					gpC_item->BltLockedOutlineOnly(item_x, item_y, POSSIBLE_COLOR, frame_id);				
			}
			else
			{
				gpC_item->BltLockedOutlineOnly(item_x, item_y, IMPOSSIBLE_COLOR, frame_id);
				
			}
		}

		//지뢰 설치 Progress Bar
		if(gbl_mine_progress)
		{
			const MItem * p_item = g_pInventory->GetItem(m_mine_grid_x, m_mine_grid_y);
			
			if (p_item && (p_item->GetItemClass() == ITEM_CLASS_MINE || p_item->GetItemClass() == ITEM_CLASS_BOMB_MATERIAL)) // Item이 있다.
			{
				if(Timer())
				{
					gpC_base->SendMessage(UI_ITEM_USE, p_item->GetID(), 0, (MItem *)p_item);
					
					EndInstallMineProgress();
					
				}
				else
				{
					TYPE_FRAMEID frame_id = p_item->GetInventoryFrameID();
					int item_x = x+GetFocusedItemGridX(p_item)+(p_item->GetGridWidth()*GRID_UNIT_PIXEL_X)/2-m_pC_mine_progress_spk->GetWidth(INVENTORY_BAR_BACK)/2;
					int item_y = y+GetFocusedItemGridY(p_item)+1;
					
					m_pC_mine_progress_spk->BltLocked(item_x, item_y, INVENTORY_BAR_BACK);
					
					Rect rect;
					rect.Set(0, 0, m_pC_mine_progress_spk->GetWidth(INVENTORY_BAR)*(GetTickCount() - gi_mine_progress)/m_dw_millisec, m_pC_mine_progress_spk->GetHeight(INVENTORY_BAR));
					m_pC_mine_progress_spk->BltLockedClip(item_x, item_y, rect, INVENTORY_BAR);
					
				}
			}
		}
		
		m_pC_button_group->Show();
		
		gpC_base->m_p_DDSurface_back->Unlock();
	}
	//
	// 아이템 개수 표시
	//
	int len = 0;
	RECT rect[60];
	int num[60];
	
	g_pInventory->SetBegin();
	WriteLogLine(__LINE__);
	
	while (g_pInventory->IsNotEnd())
	{
		
		const MItem * p_item = g_pInventory->Get();
		
		// p_item은 NULL이 반드시 아니다. 왜냐하면 존재하는 것만 Get()하기 때문이다.
		
				// 아이템 개수표시

		if( p_item == NULL )
		{			
			sprintf(g_szBugReportBuffer,"Inventory::Show itemnum ItemNULL");
			gpC_base->SendMessage( UI_SEND_BUG_REPORT, __LINE__,0,g_szBugReportBuffer);
		}

		assert(p_item);
		
		
		if(p_item->IsPileItem() || p_item->IsChargeItem())
		{
			RECT rt;
			
			rt.right = x+GetFocusedItemGridX(p_item) + p_item->GetGridWidth()*GRID_UNIT_PIXEL_X-1;
			
			for(int depth = 0, number = p_item->GetNumber(); number > 0; number/=10, depth++);
			
			if(depth == 0) depth = 1;
			rt.left = rt.right - 7*depth;
			
			rt.bottom = y+GetFocusedItemGridY(p_item) + p_item->GetGridHeight()*GRID_UNIT_PIXEL_Y;
			
			rt.top = rt.bottom - 12;
			
			rect[len] = rt;
			rt.left = max(0, rt.left);
			rt.top = max(0, rt.top);
			
			if(rt.left < rt.right && rt.top < rt.bottom)DrawAlphaBox(&rt, 0, 0, 0, g_pUserOption->ALPHA_DEPTH);
			num[len] = p_item->GetNumber();
			
			len++;
		}


		g_pInventory->Next();
	}
	WriteLogLine(__LINE__);
	
	char sz_temp[512];
	g_FL2_GetDC();	
	COLORREF markColor = RGB(220, 220, 220);//RGB(140, 140, 255);
	
	for(int i = 0; i < len; i++)
	{
		
		wsprintf(sz_temp, "%d", num[i]);
		g_PrintColorStr(rect[i].left, rect[i].top, sz_temp, gpC_base->m_item_desc_pi, markColor);	
		
	}
	WriteLogLine(__LINE__);
	// show money

	// 2004, 12, 14, sobeit modify start - 오른쪽 정렬 폰트 사용
	if(NULL != g_pMoneyManager)
	{
		if(gC_ci->IsKorean() && g_pUserOption->ShowGameMoneyWithHANGUL)
		{
			std::string sstr = g_GetStringByMoney(g_pMoneyManager->GetMoney());
			g_Print(x+m_money_button_offset_x+147, y+m_money_button_offset_y+4, sstr.c_str(), &gpC_base->m_money2_pi);
		}
		else
		{
			char money_buf[512] = {0,};
			if( g_pMoneyManager != NULL )
				wsprintf(money_buf, "%d", g_pMoneyManager->GetMoney());
			
			std::string sstr = money_buf;
			
			for(i = 3; i <= 13; i += 4)
				if(sstr.size() > i)sstr.insert(sstr.size()-i, ",");
			
			WriteLogLine(__LINE__);
			sprintf(money_buf, "%s", sstr.c_str());

			g_Print(x+m_money_button_offset_x+147, y+m_money_button_offset_y+4, money_buf, &gpC_base->m_money2_pi);
		}
	}
	
	// 2004, 12, 14, sobeit modify end

	WriteLogLine(__LINE__);
	
		
	WriteLogLine(__LINE__);
	m_pC_button_group->ShowDescription();
	g_FL2_ReleaseDC();
	WriteLogLine(__LINE__);
			
	DrawInventoryEffect();
	WriteLogLine(__LINE__);
		
	SHOW_WINDOW_ATTR;
		
		//
		// -- TEST
		//
#ifndef _LIB
		/*
		if (gpC_base->m_p_DDSurface_back->Lock())
		{
		S_SURFACEINFO	surface_info;
		S_RECT			rect;
		SetSurfaceInfo(&surface_info, gpC_base->m_p_DDSurface_back->GetDDSD());
		
		  // Grid 전체영역 표시 
		  rectangle(&surface_info, &m_grid_rect, GREEN);
		  
			//rectangle(&surface_info, &m_money_button_rect, WHITE);
			//rectangle(&surface_info, &m_close_button_rect, WHITE);
			
			  // 마우스 focus된 Grid 한 칸 표시
			  if (m_focus_grid_x != NOT_SELECTED && m_focus_grid_y != NOT_SELECTED)
			  {
			  SetRect(rect, m_grid_rect.x+(GRID_UNIT_PIXEL_X)*m_focus_grid_x,
			  m_grid_rect.y+(GRID_UNIT_PIXEL_Y)*m_focus_grid_y,
			  GRID_UNIT_PIXEL_X,
			  GRID_UNIT_PIXEL_Y);
			  
				filledRect(&surface_info, &rect, BLUE);
				}
				
				  for (int i=0; i < ITEM_REF_POINT_COUNT; i++)
				  {
				  //	putPixel(&surface_info, 
				  //		      g_item_ref_point[i].x+gpC_mouse_pointer->GetPointerX(),
				  //				g_item_ref_point[i].y+gpC_mouse_pointer->GetPointerY(),
				  //				RED);
				  }
				  
					gpC_base->m_p_DDSurface_back->Unlock();
					
					  char str[100];
					  
						sprintf(str, "focus grid (x, y) = %d, %d", m_focus_grid_x, m_focus_grid_y);
						g_Print(10, 420, str);
	}*/
#endif
	SetDebugEnd();
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::MouseControl
//
// 
//-----------------------------------------------------------------------------
bool C_VS_UI_INVENTORY::MouseControl(UINT message, int _x, int _y)
{
	Window::MouseControl(message, _x, _y);
	_x-=x; _y-=y;
	
	bool re = m_pC_button_group->MouseControl(message, _x, _y);
	
	const MItem * p_selected_item;
	
	switch (message)
	{
	case M_MOVING:
		
		//
		int i;
		int loop;
		int px, py;
		
		if (gpC_mouse_pointer->GetPickUpItem())
			loop = ITEM_REF_POINT_COUNT;
		else
		{
			loop = 1;
		}
		
		for (i=0; i < loop; i++)
		{
			if (loop == ITEM_REF_POINT_COUNT)
			{
				px = g_item_ref_point[i].x+gpC_mouse_pointer->GetPointerX()-x;
				py = g_item_ref_point[i].y+gpC_mouse_pointer->GetPointerY()-y;
			}
			else
			{
				px = _x;
				py = _y;
			}
			
			// search grid
			int distance_x = px - m_grid_rect.x;
			int distance_y = py - m_grid_rect.y;
			
			if (distance_x >= 0 && distance_x < m_grid_rect.w && 
				distance_y >= 0 && distance_y < m_grid_rect.h)
			{
				if(gpC_Imm != NULL && (m_focus_grid_x != distance_x/GRID_UNIT_PIXEL_X || m_focus_grid_y != distance_y/GRID_UNIT_PIXEL_Y))
					gpC_Imm->ForceUI(CImm::FORCE_UI_GRID);
				m_focus_grid_x = distance_x/GRID_UNIT_PIXEL_X;
				m_focus_grid_y = distance_y/GRID_UNIT_PIXEL_Y;
				
				if (loop == ITEM_REF_POINT_COUNT)
				{
					// item이 grid 영역에 어느정도 들어오면 안으로 위치시킨다.
					const MItem * p_pickup_item = gpC_mouse_pointer->GetPickUpItem();
					int a, b;
					switch (i)
					{
					case 0: // left up - first!
						a = m_focus_grid_x+p_pickup_item->GetGridWidth()-GRID_X;
						b = m_focus_grid_y+p_pickup_item->GetGridHeight()-GRID_Y;
						if (a > 0)
							m_focus_grid_x -= a;
						if (b > 0)
							m_focus_grid_y -= b;
						break;
						
					case 1: // right up
						m_focus_grid_x = 0;
						b = m_focus_grid_y+p_pickup_item->GetGridHeight()-GRID_Y;
						if (b > 0)
							m_focus_grid_y -= b;
						break;
						
					case 2: // left down
						m_focus_grid_y = 0;
						a = m_focus_grid_x+p_pickup_item->GetGridWidth()-GRID_X;
						if (a > 0)
							m_focus_grid_x -= a;
						break;
						
					case 3: // right down
						m_focus_grid_y = 0;
						if (m_focus_grid_x+1 <= p_pickup_item->GetGridHeight())
							m_focus_grid_x = 0;
					}
				}
				 
				p_selected_item = g_pInventory->GetItem(m_focus_grid_x, m_focus_grid_y);
				if (p_selected_item != NULL)
				{
					MItem *pMouseItem = gpC_mouse_pointer->GetPickUpItem();
					g_descriptor_manager.Set(DID_ITEM, x+GetFocusedItemGridX(p_selected_item), y+GetFocusedItemGridY(p_selected_item), (void *)p_selected_item);
				}
				
				return true;
				//					break; // escape 'for'
			}
		}
		if(m_focus_grid_x != NOT_SELECTED || m_focus_grid_y != NOT_SELECTED)
			gpC_Imm->ForceUI(CImm::FORCE_UI_GRID);
		m_focus_grid_x = NOT_SELECTED;
		m_focus_grid_y = NOT_SELECTED;
		break;
		
	case M_LEFTBUTTON_DOWN:
	case M_LB_DOUBLECLICK:

			if(gC_vs_ui.inventory_mode == 2) 
				return false;

			// by csm 개인상점에 있는 물건을 집을 수 없다. 
			g_pInventory->SetBegin();
			while (g_pInventory->IsNotEnd())
			{
				MItem * p_item = g_pInventory->GetItem(m_focus_grid_x, m_focus_grid_y);
				if(p_item)
				{
					if(p_item->GetPersnal() == true) 
					{
						return true;
						break; 
					}
					
				}
				g_pInventory->Next();
			}


			if(gC_vs_ui.inventory_mode != 1)// 개인상점 오픈모드 
			{
				if (gC_vs_ui.inventory_mode == NULL && gpC_mouse_pointer->GetPickUpItem() == NULL && re && g_pInventory->GetItem(m_focus_grid_x, m_focus_grid_y) == NULL)
					//TestGridRect(_x, _y) == false && re)
				{
					MoveReady();
					SetOrigin(_x, _y);
					break;
				}
				
				//
				// Item을 집던가 놓는다.
				//
				{
					bool ret = Click(m_grid_rect.x, m_grid_rect.y);
					
					if (ret)
						EMPTY_MOVE;
				}
			}
			

		//
		// money button / close button
		//
		/*			if (m_bl_money_button_focused)
		m_bl_money_button_pushed = true;
		else if (m_bl_desc_button_focused)
		m_bl_desc_button_pushed = true;
		else if (m_bl_bike_button_focused)
		m_bl_bike_button_pushed = true;
		else if (m_bl_close_button_focused)
		m_bl_close_button_pushed = true;
		else if (m_bl_help_button_focused)
		m_bl_help_button_pushed = true;
		*/			break;
		
	case M_LEFTBUTTON_UP:
		CancelPushState();
		break;
		
	case M_RIGHTBUTTON_DOWN:
		//
		// Item을 사용한다.
		//
		if(gC_vs_ui.inventory_mode == 1)
		{
			MItem * p_item = g_pInventory->GetItem(m_focus_grid_x, m_focus_grid_y);			
			m_p_persnal_item = p_item;
			if(g_pInventory->GetItem(m_focus_grid_x, m_focus_grid_y) != NULL)
			{
				
				MItem * p_item = g_pInventory->GetItem(m_focus_grid_x, m_focus_grid_y);
				if (p_item != NULL)
				{
					if( p_item->GetItemClass() == ITEM_CLASS_EVENT_STAR &&
						!g_pSystemAvailableManager->IsAvailableEnchantSystem() )
						break;
					
					m_pC_dialog_drop_money = new C_VS_UI_MONEY_DIALOG(x+m_money_button_offset_x, y+m_money_button_offset_y+gpC_global_resource->m_pC_assemble_box_button_spk->GetHeight(C_GLOBAL_RESOURCE::AB_BUTTON_MONEY), 2, 0, 
						ExecF_SellConfirm2, DIALOG_OK|DIALOG_CANCEL, 10, 
					C_VS_UI_MONEY_DIALOG::MONEY_SELL_ITEM);	// by sigi
					m_pC_dialog_drop_money->Start();

				}
			}
			
		}
		else
		{
			
			if (gbl_sell_running == true)
			{
				int mx=x,my=y;
				if (gbl_item_trade_lock == false)
				{
					MItem * p_item = g_pInventory->GetItem(m_focus_grid_x, m_focus_grid_y);
					if(p_item && p_item->GetItemClass() == ITEM_CLASS_SKULL)
					{
						int price = 0;
						for(int y = 0; y < GRID_Y; y++)
						{
							for(int x = 0; x < GRID_X; x++)
							{
								MItem * p_sell_item = g_pInventory->GetItem(x, y);
								if(p_sell_item && p_sell_item->GetItemClass() == ITEM_CLASS_SKULL)
									price += g_pPriceManager->GetItemPrice(p_sell_item, MPriceManager::PC_TO_NPC)*p_sell_item->GetNumber();
							}
						}
						g_StartSellAllConfirmDialog(
							mx+p_item->GetGridX()*GRID_UNIT_PIXEL_X, 
							my+(1+p_item->GetGridY()+p_item->GetGridWidth())*GRID_UNIT_PIXEL_Y, price);
					}
				}
			}
			else Use();
			
		}
		break;
		
	case M_RIGHTBUTTON_UP:
		EndInstallMineProgress();
		break;
	}
	
	return true;
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::ResetRect
//
// 전체 Grid rect를 설정한다. 이것은 Inventory의 이동이 있을 때마다 해줘야 한다.
//-----------------------------------------------------------------------------
void C_VS_UI_INVENTORY::ResetRect()
{
	m_grid_rect.Set(m_grid_start_offset_x, 
								m_grid_start_offset_y, 
								GRID_UNIT_PIXEL_X*GRID_X, GRID_UNIT_PIXEL_Y*GRID_Y);
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::Use
//
// 
//-----------------------------------------------------------------------------
void C_VS_UI_INVENTORY::Use()
{
	if (m_focus_grid_x == NOT_SELECTED || m_focus_grid_y == NOT_SELECTED ||
		gbl_item_lock /*|| gbl_gear_lock*/)
		return;
	
	if (gpC_mouse_pointer->GetPickUpItem())
	{
		
	}
	else
	{
		const MItem * p_item = g_pInventory->GetItem(m_focus_grid_x, m_focus_grid_y);
		
		if (p_item) // Item이 있다.
		{
			m_mine_grid_x = m_focus_grid_x;
			m_mine_grid_y = m_focus_grid_y;
			if(p_item->GetItemClass() == ITEM_CLASS_PET_FOOD)
			{
				PETINFO *pPetInfo = gC_vs_ui.GetMyPetInfo();
				if( pPetInfo != NULL && pPetInfo->EXIST )
				{
					TYPE_ITEMTYPE itemType = pPetInfo->ITEM_TYPE;
					TYPE_ITEMTYPE foodType = p_item->GetItemType();
					// add by svi 2009-6-3
					if( ( foodType >=0 && foodType <= 5 && (itemType == 1 || itemType == 2 || itemType ==6 || itemType ==7 || itemType ==8) ) ||
						(foodType >= 6 && foodType <= 9 && itemType == 3) ||
						(foodType >= 10 && foodType <= 13 && itemType == 4)||
						(foodType >= 14 && foodType <= 17 && itemType == 5))
					/*
					if( ( foodType >=0 && foodType <= 5 && (itemType == 1 || itemType == 2) ) ||
						(foodType >= 6 && foodType <= 9 && itemType == 3) ||
						(foodType >= 10 && foodType <= 13 && itemType == 4)||
						(foodType >= 14 && foodType <= 17 && itemType == 5))
						*/
					{
						gC_vs_ui.RunUsePetFood();
					}
					return;
				}
			}
			else 
			if(p_item->GetItemClass() == ITEM_CLASS_PET_ITEM && p_item->GetItemType() >2) // 2차 펫 소환아이템 이면
			{
				switch(g_eRaceInterface)
				{
					case RACE_SLAYER:
						if((*g_pSkillManager)[SKILLDOMAIN_BLADE].GetDomainLevel() < 40 &&
						(*g_pSkillManager)[SKILLDOMAIN_SWORD].GetDomainLevel() < 40 &&
						(*g_pSkillManager)[SKILLDOMAIN_GUN].GetDomainLevel() < 40 &&
						(*g_pSkillManager)[SKILLDOMAIN_HEAL].GetDomainLevel() < 40 &&
						(*g_pSkillManager)[SKILLDOMAIN_ENCHANT].GetDomainLevel() < 40)
//						if(g_char_slot_ingame.DOMAIN_BLADE		< 40 &&
//							g_char_slot_ingame.DOMAIN_ENCHANT	< 40 &&
//							g_char_slot_ingame.DOMAIN_GUN		< 40 &&
//							g_char_slot_ingame.DOMAIN_HEAL		< 40 &&
//							g_char_slot_ingame.DOMAIN_SWORD) // 렙 40 이하는 못 쓴다.
							{
								gpC_base->SendMessage(UI_MESSAGE_BOX, UI_STRING_MESSAGE_CANNOT_SUMMON_2ND_PET, 0, 	NULL);
								return;
							}
						break;

					case RACE_VAMPIRE:
					case RACE_OUSTERS:
						if(g_char_slot_ingame.level < 40)
						{
							gpC_base->SendMessage(UI_MESSAGE_BOX, UI_STRING_MESSAGE_CANNOT_SUMMON_2ND_PET, 0, 	NULL);
							return;
						}
						break;		
				}
			}
			else 
			if(p_item->GetItemClass() == ITEM_CLASS_SMS_ITEM)
			{
				gC_vs_ui.RunAskUseItemDialog(C_VS_UI_ASK_DIALOG::ASK_USE_SMSITEM);
				return;
			}
			else
			if(p_item->GetItemClass() == ITEM_CLASS_EVENT_GIFT_BOX &&
				p_item->GetItemType() > 21 && p_item->GetItemType() < 26)
			{
				gC_vs_ui.RunAskUseItemDialog(C_VS_UI_ASK_DIALOG::ASK_USE_NAMINGITEM);
				return;
			}
			if(IsPlayerInSafePosition() && (p_item->GetItemClass() == ITEM_CLASS_BOMB_MATERIAL || p_item->GetItemClass() == ITEM_CLASS_MINE))
				return;

			if(p_item->GetItemClass() == ITEM_CLASS_DYE_POTION && p_item->GetItemType() == 48)
			{
				// 재확인해야하는거면
				g_pTempItem = const_cast<MItem*>(p_item);
				g_StartConfirmChangeSex( -1, -1 );				
			} 
			else if(StartInstallMineProgress(m_focus_grid_x, m_focus_grid_y) == false &&
				StartCreateMineProgress(m_focus_grid_x, m_focus_grid_y) == false &&
				StartCreateBombProgress(m_focus_grid_x, m_focus_grid_y) == false				
				)
			{
							
				gpC_base->SendMessage(UI_ITEM_USE, p_item->GetID(), 0, (MItem *)p_item);
			}
		}
	}
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::StartInstallMineProgress
//-----------------------------------------------------------------------------
bool C_VS_UI_INVENTORY::StartInstallMineProgress(int focus_grid_x, int focus_grid_y)
{
	if(IsPlayerInSafePosition())
		return false;
	
	const MItem * p_item = g_pInventory->GetItem(focus_grid_x, focus_grid_y);
	if(p_item != NULL && g_eRaceInterface == RACE_SLAYER && p_item->GetItemClass() == ITEM_CLASS_MINE &&
		g_pSkillAvailable->IsEnableSkill( SKILL_INSTALL_MINE )
		&& (*g_pSkillInfoTable)[SKILL_INSTALL_MINE].IsEnable()
		&& (*g_pSkillInfoTable)[SKILL_INSTALL_MINE].IsAvailableTime()
		)	// 지뢰인경우 지뢰 progress바 보여줌
	{
		int mine_level = (*g_pSkillInfoTable)[SKILL_INSTALL_MINE].GetExpLevel();
//		m_dw_millisec = min(30, max(20, 30-mine_level/10))*100;
		m_dw_millisec = ( 10 - ( mine_level /25 ) ) * 1000;
		Timer(true);
		gbl_mine_progress = true;
		m_mine_grid_x = focus_grid_x;
		m_mine_grid_y = focus_grid_y;
	}
	else
		gbl_mine_progress = false;
	
	return gbl_mine_progress;
}

// 0~4 : BOMB MATERIAL 5~9 : MINE MATERIAL
//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::StartCreateMineProgress
//-----------------------------------------------------------------------------
bool C_VS_UI_INVENTORY::StartCreateMineProgress(int focus_grid_x, int focus_grid_y)
{
	if(IsPlayerInSafePosition())
		return false;
	
	const MItem * p_item = g_pInventory->GetItem(focus_grid_x, focus_grid_y);
	if(p_item != NULL && g_eRaceInterface == RACE_SLAYER && p_item->GetItemClass() == ITEM_CLASS_BOMB_MATERIAL && p_item->GetItemType() > 4 &&
		g_pSkillAvailable->IsEnableSkill( SKILL_MAKE_MINE )
		&& (*g_pSkillInfoTable)[SKILL_MAKE_MINE].IsEnable()
		&& (*g_pSkillInfoTable)[SKILL_MAKE_MINE].IsAvailableTime()
		)	// 지뢰인경우 지뢰 progress바 보여줌
	{
		int mine_level = (*g_pSkillInfoTable)[SKILL_MAKE_MINE].GetExpLevel();
		m_dw_millisec = min(30, max(20, 30-mine_level/10))*100;

//		m_dw_millisec = ( 10 - ( mine_level /25 ) ) * 1000;
		Timer(true);
		gbl_mine_progress = true;
		m_mine_grid_x = focus_grid_x;
		m_mine_grid_y = focus_grid_y;
	}
	else
		gbl_mine_progress = false;
	
	return gbl_mine_progress;
}

// 0~4 : BOMB MATERIAL 5~9 : MINE MATERIAL
//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::StartCreateBombProgress
//-----------------------------------------------------------------------------
bool C_VS_UI_INVENTORY::StartCreateBombProgress(int focus_grid_x, int focus_grid_y)
{
	if(IsPlayerInSafePosition())
		return false;
	
	const MItem * p_item = g_pInventory->GetItem(focus_grid_x, focus_grid_y);
	if(p_item != NULL && g_eRaceInterface == RACE_SLAYER && p_item->GetItemClass() == ITEM_CLASS_BOMB_MATERIAL && p_item->GetItemType() < 5 &&
		g_pSkillAvailable->IsEnableSkill( SKILL_MAKE_BOMB )
		&& (*g_pSkillInfoTable)[SKILL_MAKE_BOMB].IsEnable()
		&& (*g_pSkillInfoTable)[SKILL_MAKE_BOMB].IsAvailableTime()
		)	// 지뢰인경우 지뢰 progress바 보여줌
	{
		int mine_level = (*g_pSkillInfoTable)[SKILL_MAKE_BOMB].GetExpLevel();
		m_dw_millisec = min(30, max(20, 30-mine_level/10))*100;
		Timer(true);
		gbl_mine_progress = true;
		m_mine_grid_x = focus_grid_x;
		m_mine_grid_y = focus_grid_y;
	}
	else
		gbl_mine_progress = false;
	
	return gbl_mine_progress;
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::Click
//
// 현재 Item을 들고 있으면 놓던가 교체하고, 들고 있지 않으면 Inventory에 있는
// 것을 집는다.
//
// 뭔가 했다면 true를, 그렇지않으면 false를 반환한다.
//
// grid_start_x, grid_start_y는 inventory grid 시작점이다. 이것을 참조하여 item
// (x, y)를 구한다.
//-----------------------------------------------------------------------------
bool C_VS_UI_INVENTORY::Click(int grid_start_x, int grid_start_y)
{
	
}
void C_VS_UI_INVENTORY::KeyboardControl(UINT message, UINT key, long extra)
{
	Window::KeyboardControl(message, key, extra);
	
	//	if (message == WM_KEYDOWN)
	//	{
	//		switch (key)
	//		{
	//		case VK_SHIFT:
	//			m_bl_shift = true;
	//			break;
	//		}
	//	}
	//	else if(message == WM_KEYUP)
	//	{
	//		switch(key)
	//		{
	//		case VK_SHIFT:
	//			m_bl_shift = false;
	//			break;
	//		}
	//	}
}

//-----------------------------------------------------------------------------
// C_VS_UI_INVENTORY::Timer
//
//-----------------------------------------------------------------------------
bool	C_VS_UI_INVENTORY::Timer(bool reset)
{
	if(reset)
	{
		gi_mine_progress = GetTickCount();
	}
	else if(gi_mine_progress+m_dw_millisec <= GetTickCount())
	{
		gi_mine_progress = GetTickCount();
		return true;
	}
	
	return false;
}
