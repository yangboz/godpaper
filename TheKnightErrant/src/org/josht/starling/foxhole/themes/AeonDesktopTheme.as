package org.josht.starling.foxhole.themes
{
	import flash.geom.Rectangle;
	
	import org.josht.starling.display.Scale3Image;
	import org.josht.starling.display.Scale9Image;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Callout;
	import org.josht.starling.foxhole.controls.Check;
	import org.josht.starling.foxhole.controls.List;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.ProgressBar;
	import org.josht.starling.foxhole.controls.Radio;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.ScrollBar;
	import org.josht.starling.foxhole.controls.Scroller;
	import org.josht.starling.foxhole.controls.SimpleScrollBar;
	import org.josht.starling.foxhole.controls.Slider;
	import org.josht.starling.foxhole.controls.TextInput;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.controls.popups.DropDownPopUpContentManager;
	import org.josht.starling.foxhole.controls.renderers.BaseDefaultItemRenderer;
	import org.josht.starling.foxhole.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import org.josht.starling.foxhole.controls.renderers.DefaultGroupedListItemRenderer;
	import org.josht.starling.foxhole.controls.renderers.DefaultListItemRenderer;
	import org.josht.starling.foxhole.controls.text.BitmapFontTextRenderer;
	import org.josht.starling.foxhole.core.AddedWatcher;
	import org.josht.starling.foxhole.core.FoxholeControl;
	import org.josht.starling.foxhole.text.BitmapFontTextFormat;
	import org.josht.starling.textures.Scale3Textures;
	import org.josht.starling.textures.Scale9Textures;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AeonDesktopTheme extends AddedWatcher implements IFoxholeTheme
	{
		[Embed(source="/../assets/images/aeon.png")]
		protected static const ATLAS_IMAGE:Class;

		[Embed(source="/../assets/images/aeon.xml",mimeType="application/octet-stream")]
		protected static const ATLAS_XML:Class;

		[Embed(source="/../assets/images/aeon/arial.fnt",mimeType="application/octet-stream")]
		protected static const FONT_XML:Class;

		protected static const ATLAS:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ATLAS_IMAGE(), false), XML(new ATLAS_XML()));

		protected static const BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 70, 10);
		protected static const SELECTED_BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 52, 10);
		protected static const HSLIDER_FIRST_REGION:Number = 2;
		protected static const HSLIDER_SECOND_REGION:Number = 75;
		protected static const TEXT_INPUT_SCALE_9_GRID:Rectangle = new Rectangle(2, 2, 148, 18);
		protected static const VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID:Rectangle = new Rectangle(2, 5, 6, 42);
		protected static const VERTICAL_SCROLL_BAR_TRACK_SCALE_9_GRID:Rectangle = new Rectangle(2, 1, 11, 2);
		protected static const VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(2, 2, 11, 10);
		protected static const HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID:Rectangle = new Rectangle(5, 2, 42, 6);
		protected static const HORIZONTAL_SCROLL_BAR_TRACK_SCALE_9_GRID:Rectangle = new Rectangle(1, 2, 2, 11);
		protected static const HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(2, 2, 10, 11);
		protected static const SIMPLE_BORDER_SCALE_9_GRID:Rectangle = new Rectangle(2, 2, 2, 2);
		protected static const PANEL_BORDER_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 2, 2);
		protected static const HEADER_SCALE_9_GRID:Rectangle = new Rectangle(0, 0, 4, 28);

		protected static const BUTTON_UP_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-up-skin"), BUTTON_SCALE_9_GRID);
		protected static const BUTTON_HOVER_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-hover-skin"), BUTTON_SCALE_9_GRID);
		protected static const BUTTON_DOWN_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-down-skin"), BUTTON_SCALE_9_GRID);
		protected static const BUTTON_DISABLED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-disabled-skin"), BUTTON_SCALE_9_GRID);
		protected static const BUTTON_SELECTED_UP_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-selected-up-skin"), SELECTED_BUTTON_SCALE_9_GRID);
		protected static const BUTTON_SELECTED_HOVER_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-selected-hover-skin"), SELECTED_BUTTON_SCALE_9_GRID);
		protected static const BUTTON_SELECTED_DOWN_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-selected-down-skin"), SELECTED_BUTTON_SCALE_9_GRID);
		protected static const BUTTON_SELECTED_DISABLED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-selected-disabled-skin"), SELECTED_BUTTON_SCALE_9_GRID);

		protected static const HSLIDER_THUMB_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("hslider-thumb-up-skin");
		protected static const HSLIDER_THUMB_HOVER_SKIN_TEXTURE:Texture = ATLAS.getTexture("hslider-thumb-hover-skin");
		protected static const HSLIDER_THUMB_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("hslider-thumb-down-skin");
		protected static const HSLIDER_THUMB_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("hslider-thumb-disabled-skin");
		protected static const HSLIDER_TRACK_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("hslider-track-skin"), HSLIDER_FIRST_REGION, HSLIDER_SECOND_REGION, Scale3Textures.DIRECTION_HORIZONTAL);

		protected static const VSLIDER_THUMB_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("vslider-thumb-up-skin");
		protected static const VSLIDER_THUMB_HOVER_SKIN_TEXTURE:Texture = ATLAS.getTexture("vslider-thumb-hover-skin");
		protected static const VSLIDER_THUMB_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("vslider-thumb-down-skin");
		protected static const VSLIDER_THUMB_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("vslider-thumb-disabled-skin");
		protected static const VSLIDER_TRACK_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("vslider-track-skin"), HSLIDER_FIRST_REGION, HSLIDER_SECOND_REGION, Scale3Textures.DIRECTION_VERTICAL);

		protected static const ITEM_RENDERER_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("item-renderer-up-skin");
		protected static const ITEM_RENDERER_HOVER_SKIN_TEXTURE:Texture = ATLAS.getTexture("item-renderer-hover-skin");
		protected static const ITEM_RENDERER_SELECTED_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("item-renderer-selected-up-skin");

		protected static const HEADER_BACKGROUND_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("header-background-skin"), HEADER_SCALE_9_GRID);

		protected static const CHECK_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("check-up-icon");
		protected static const CHECK_HOVER_ICON_TEXTURE:Texture = ATLAS.getTexture("check-hover-icon");
		protected static const CHECK_DOWN_ICON_TEXTURE:Texture = ATLAS.getTexture("check-down-icon");
		protected static const CHECK_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("check-disabled-icon");
		protected static const CHECK_SELECTED_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("check-selected-up-icon");
		protected static const CHECK_SELECTED_HOVER_ICON_TEXTURE:Texture = ATLAS.getTexture("check-selected-hover-icon");
		protected static const CHECK_SELECTED_DOWN_ICON_TEXTURE:Texture = ATLAS.getTexture("check-selected-down-icon");
		protected static const CHECK_SELECTED_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("check-selected-disabled-icon");

		protected static const RADIO_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-up-icon");
		protected static const RADIO_HOVER_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-hover-icon");
		protected static const RADIO_DOWN_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-down-icon");
		protected static const RADIO_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-disabled-icon");
		protected static const RADIO_SELECTED_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-selected-up-icon");
		protected static const RADIO_SELECTED_HOVER_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-selected-hover-icon");
		protected static const RADIO_SELECTED_DOWN_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-selected-down-icon");
		protected static const RADIO_SELECTED_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-selected-disabled-icon");

		protected static const PICKER_LIST_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("picker-list-up-icon");
		protected static const PICKER_LIST_HOVER_ICON_TEXTURE:Texture = ATLAS.getTexture("picker-list-hover-icon");
		protected static const PICKER_LIST_DOWN_ICON_TEXTURE:Texture = ATLAS.getTexture("picker-list-down-icon");
		protected static const PICKER_LIST_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("picker-list-disabled-icon");

		protected static const TEXT_INPUT_BACKGROUND_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("text-input-background-skin"), TEXT_INPUT_SCALE_9_GRID);
		protected static const TEXT_INPUT_BACKGROUND_DISABLED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("text-input-background-disabled-skin"), TEXT_INPUT_SCALE_9_GRID);

		protected static const VERTICAL_SCROLL_BAR_THUMB_UP_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("vertical-scroll-bar-thumb-up-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		protected static const VERTICAL_SCROLL_BAR_THUMB_HOVER_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("vertical-scroll-bar-thumb-hover-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		protected static const VERTICAL_SCROLL_BAR_THUMB_DOWN_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("vertical-scroll-bar-thumb-down-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		protected static const VERTICAL_SCROLL_BAR_TRACK_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("vertical-scroll-bar-track-skin"), VERTICAL_SCROLL_BAR_TRACK_SCALE_9_GRID);
		protected static const VERTICAL_SCROLL_BAR_THUMB_ICON:Texture = ATLAS.getTexture("vertical-scroll-bar-thumb-icon");
		protected static const VERTICAL_SCROLL_BAR_STEP_BUTTON_UP_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("vertical-scroll-bar-step-button-up-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		protected static const VERTICAL_SCROLL_BAR_STEP_BUTTON_HOVER_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("vertical-scroll-bar-step-button-hover-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		protected static const VERTICAL_SCROLL_BAR_STEP_BUTTON_DOWN_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("vertical-scroll-bar-step-button-down-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		protected static const VERTICAL_SCROLL_BAR_STEP_BUTTON_DISABLED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("vertical-scroll-bar-step-button-disabled-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		protected static const VERTICAL_SCROLL_BAR_DECREMENT_BUTTON_ICON_TEXTURE:Texture = ATLAS.getTexture("vertical-scroll-bar-decrement-button-icon");
		protected static const VERTICAL_SCROLL_BAR_INCREMENT_BUTTON_ICON_TEXTURE:Texture = ATLAS.getTexture("vertical-scroll-bar-increment-button-icon");

		protected static const HORIZONTAL_SCROLL_BAR_THUMB_UP_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("horizontal-scroll-bar-thumb-up-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		protected static const HORIZONTAL_SCROLL_BAR_THUMB_HOVER_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("horizontal-scroll-bar-thumb-hover-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		protected static const HORIZONTAL_SCROLL_BAR_THUMB_DOWN_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("horizontal-scroll-bar-thumb-down-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		protected static const HORIZONTAL_SCROLL_BAR_TRACK_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("horizontal-scroll-bar-track-skin"), HORIZONTAL_SCROLL_BAR_TRACK_SCALE_9_GRID);
		protected static const HORIZONTAL_SCROLL_BAR_THUMB_ICON:Texture = ATLAS.getTexture("horizontal-scroll-bar-thumb-icon");
		protected static const HORIZONTAL_SCROLL_BAR_STEP_BUTTON_UP_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("horizontal-scroll-bar-step-button-up-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		protected static const HORIZONTAL_SCROLL_BAR_STEP_BUTTON_HOVER_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("horizontal-scroll-bar-step-button-hover-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		protected static const HORIZONTAL_SCROLL_BAR_STEP_BUTTON_DOWN_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("horizontal-scroll-bar-step-button-down-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		protected static const HORIZONTAL_SCROLL_BAR_STEP_BUTTON_DISABLED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("horizontal-scroll-bar-step-button-disabled-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		protected static const HORIZONTAL_SCROLL_BAR_DECREMENT_BUTTON_ICON_TEXTURE:Texture = ATLAS.getTexture("horizontal-scroll-bar-decrement-button-icon");
		protected static const HORIZONTAL_SCROLL_BAR_INCREMENT_BUTTON_ICON_TEXTURE:Texture = ATLAS.getTexture("horizontal-scroll-bar-increment-button-icon");

		protected static const SIMPLE_BORDER_BACKGROUND_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("simple-border-background-skin"), SIMPLE_BORDER_SCALE_9_GRID);
		protected static const PANEL_BORDER_BACKGROUND_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("panel-background-skin"), PANEL_BORDER_SCALE_9_GRID);

		protected static const PROGRESS_BAR_FILL_SKIN_TEXTURE:Texture = ATLAS.getTexture("progress-bar-fill-skin");

		protected static const BITMAP_FONT:BitmapFont = new BitmapFont(ATLAS.getTexture("arial_0"), XML(new FONT_XML()));

		protected static const BACKGROUND_COLOR:uint = 0x869CA7;
		protected static const PRIMARY_TEXT_COLOR:uint = 0x0B333C;

		protected static function verticalScrollBarFactory():ScrollBar
		{
			const scrollBar:ScrollBar = new ScrollBar();
			scrollBar.direction = ScrollBar.DIRECTION_VERTICAL;
			return scrollBar;
		}

		protected static function horizontalScrollBarFactory():ScrollBar
		{
			const scrollBar:ScrollBar = new ScrollBar();
			scrollBar.direction = ScrollBar.DIRECTION_HORIZONTAL;
			return scrollBar;
		}

		public function AeonDesktopTheme(root:DisplayObject)
		{
			super(root);
			Starling.current.nativeStage.color = BACKGROUND_COLOR;
			if(root.stage)
			{
				root.stage.color = BACKGROUND_COLOR;
			}
			else
			{
				root.addEventListener(Event.ADDED_TO_STAGE, root_addedToStageHandler);
			}
			this.initialize();
		}

		protected var _fontSize:Number;

		public function get originalDPI():int
		{
			return 72;
		}

		public function get scaleToDPI():Boolean
		{
			return false;
		}

		protected function initialize():void
		{
			this._fontSize = BITMAP_FONT.size;
			this.setInitializerForClass(BitmapFontTextRenderer, labelInitializer);
			this.setInitializerForClass(Button, buttonInitializer);
			this.setInitializerForClass(Button, toggleSwitchOnTrackInitializer, "foxhole-toggle-switch-on-track");
			this.setInitializerForClass(Button, toggleSwitchThumbInitializer, "foxhole-toggle-switch-thumb");
			this.setInitializerForClass(Button, pickerListButtonInitializer, "foxhole-picker-list-button");
			this.setInitializerForClass(Button, nothingInitializer, "foxhole-simple-scroll-bar-thumb");
			this.setInitializerForClass(Button, nothingInitializer, "foxhole-scroll-bar-thumb");
			this.setInitializerForClass(Button, nothingInitializer, "foxhole-scroll-bar-decrement-button");
			this.setInitializerForClass(Button, nothingInitializer, "foxhole-scroll-bar-increment-button");
			this.setInitializerForClass(Button, nothingInitializer, "foxhole-scroll-bar-minimum-track");
			this.setInitializerForClass(Button, nothingInitializer, "foxhole-scroll-bar-maximum-track");
			this.setInitializerForClass(Button, nothingInitializer, "foxhole-slider-thumb");
			this.setInitializerForClass(Button, nothingInitializer, "foxhole-slider-minimum-track");
			this.setInitializerForClass(Button, nothingInitializer, "foxhole-slider-maximum-track");
			this.setInitializerForClass(Check, checkInitializer);
			this.setInitializerForClass(Radio, radioInitializer);
			this.setInitializerForClass(ToggleSwitch, toggleSwitchInitializer);
			this.setInitializerForClass(Slider, sliderInitializer);
			this.setInitializerForClass(SimpleScrollBar, simpleScrollBarInitializer);
			this.setInitializerForClass(ScrollBar, scrollBarInitializer);
			this.setInitializerForClass(TextInput, textInputInitializer);
			this.setInitializerForClass(ProgressBar, progressBarInitializer);
			this.setInitializerForClass(Scroller, scrollerInitializer);
			this.setInitializerForClass(List, listInitializer);
			this.setInitializerForClass(List, nothingInitializer, "foxhole-picker-list-list");
			this.setInitializerForClass(PickerList, pickerListInitializer);
			this.setInitializerForClass(DefaultListItemRenderer, defaultItemRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, defaultItemRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, defaultHeaderOrFooterRendererInitializer);
			this.setInitializerForClass(ScreenHeader, screenHeaderInitializer);
			this.setInitializerForClass(Callout, calloutInitializer);
		}

		protected function nothingInitializer(target:FoxholeControl):void
		{
			//do nothing
		}

		protected function labelInitializer(label:BitmapFontTextRenderer):void
		{
			label.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
		}

		protected function buttonInitializer(button:Button):void
		{
			button.defaultSkin = new Scale9Image(BUTTON_UP_SKIN_TEXTURES);
			button.hoverSkin = new Scale9Image(BUTTON_HOVER_SKIN_TEXTURES);
			button.downSkin = new Scale9Image(BUTTON_DOWN_SKIN_TEXTURES);
			button.disabledSkin = new Scale9Image(BUTTON_DISABLED_SKIN_TEXTURES);
			button.defaultSelectedSkin = new Scale9Image(BUTTON_SELECTED_UP_SKIN_TEXTURES);
			button.selectedHoverSkin = new Scale9Image(BUTTON_SELECTED_HOVER_SKIN_TEXTURES);
			button.selectedDownSkin = new Scale9Image(BUTTON_SELECTED_DOWN_SKIN_TEXTURES);
			button.selectedDisabledSkin = new Scale9Image(BUTTON_SELECTED_DISABLED_SKIN_TEXTURES);

			button.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);

			button.paddingTop = button.paddingBottom = 2;
			button.paddingLeft = button.paddingRight = 10;
			button.gap = 2;
			button.minWidth = button.minHeight = 12;
		}

		protected function pickerListButtonInitializer(button:Button):void
		{
			this.buttonInitializer(button);

			button.defaultIcon = new Image(PICKER_LIST_UP_ICON_TEXTURE);
			button.hoverIcon = new Image(PICKER_LIST_HOVER_ICON_TEXTURE);
			button.downIcon = new Image(PICKER_LIST_DOWN_ICON_TEXTURE);
			button.disabledIcon = new Image(PICKER_LIST_DISABLED_ICON_TEXTURE);
			button.gap = Number.POSITIVE_INFINITY; //fill as completely as possible
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			button.iconPosition = Button.ICON_POSITION_RIGHT;
			button.paddingRight = 6;
		}

		protected function toggleSwitchOnTrackInitializer(track:Button):void
		{
			track.defaultSkin = new Scale9Image(BUTTON_SELECTED_UP_SKIN_TEXTURES);
		}

		protected function toggleSwitchThumbInitializer(thumb:Button):void
		{
			this.buttonInitializer(thumb);
			thumb.width = thumb.height = BUTTON_UP_SKIN_TEXTURES.texture.frame.height;
		}

		protected function checkInitializer(check:Check):void
		{
			check.defaultIcon = new Image(CHECK_UP_ICON_TEXTURE);
			check.hoverIcon = new Image(CHECK_HOVER_ICON_TEXTURE);
			check.downIcon = new Image(CHECK_DOWN_ICON_TEXTURE);
			check.disabledIcon = new Image(CHECK_DISABLED_ICON_TEXTURE);
			check.defaultSelectedIcon = new Image(CHECK_SELECTED_UP_ICON_TEXTURE);
			check.selectedHoverIcon = new Image(CHECK_SELECTED_HOVER_ICON_TEXTURE);
			check.selectedDownIcon = new Image(CHECK_SELECTED_DOWN_ICON_TEXTURE);
			check.selectedDisabledIcon = new Image(CHECK_SELECTED_DISABLED_ICON_TEXTURE);

			check.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);

			check.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			check.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
		}

		protected function radioInitializer(radio:Radio):void
		{
			radio.defaultIcon = new Image(RADIO_UP_ICON_TEXTURE);
			radio.hoverIcon = new Image(RADIO_HOVER_ICON_TEXTURE);
			radio.downIcon = new Image(RADIO_DOWN_ICON_TEXTURE);
			radio.disabledIcon = new Image(RADIO_DISABLED_ICON_TEXTURE);
			radio.defaultSelectedIcon = new Image(RADIO_SELECTED_UP_ICON_TEXTURE);
			radio.selectedHoverIcon = new Image(RADIO_SELECTED_HOVER_ICON_TEXTURE);
			radio.selectedDownIcon = new Image(RADIO_SELECTED_DOWN_ICON_TEXTURE);
			radio.selectedDisabledIcon = new Image(RADIO_SELECTED_DISABLED_ICON_TEXTURE);

			radio.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);

			radio.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			radio.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
		}

		protected function toggleSwitchInitializer(toggle:ToggleSwitch):void
		{
			toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;
			toggle.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
		}

		protected function sliderInitializer(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_SINGLE;
			slider.minimumPadding = slider.maximumPadding = -VSLIDER_THUMB_UP_SKIN_TEXTURE.height / 2;

			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				slider.thumbProperties.defaultSkin = new Image(VSLIDER_THUMB_UP_SKIN_TEXTURE);
				slider.thumbProperties.hoverSkin = new Image(VSLIDER_THUMB_HOVER_SKIN_TEXTURE);
				slider.thumbProperties.downSkin = new Image(VSLIDER_THUMB_DOWN_SKIN_TEXTURE);
				slider.thumbProperties.disabledSkin = new Image(VSLIDER_THUMB_DISABLED_SKIN_TEXTURE);
				slider.minimumTrackProperties.defaultSkin = new Scale3Image(VSLIDER_TRACK_SKIN_TEXTURES);
			}
			else //horizontal
			{
				slider.thumbProperties.defaultSkin = new Image(HSLIDER_THUMB_UP_SKIN_TEXTURE);
				slider.thumbProperties.hoverSkin = new Image(HSLIDER_THUMB_HOVER_SKIN_TEXTURE);
				slider.thumbProperties.downSkin = new Image(HSLIDER_THUMB_DOWN_SKIN_TEXTURE);
				slider.thumbProperties.disabledSkin = new Image(HSLIDER_THUMB_DISABLED_SKIN_TEXTURE);
				slider.minimumTrackProperties.defaultSkin = new Scale3Image(HSLIDER_TRACK_SKIN_TEXTURES);
			}
		}

		protected function simpleScrollBarInitializer(scrollBar:SimpleScrollBar):void
		{
			if(scrollBar.direction == Slider.DIRECTION_VERTICAL)
			{
				scrollBar.thumbProperties.defaultSkin = new Scale9Image(VERTICAL_SCROLL_BAR_THUMB_UP_SKIN_TEXTURES);
				scrollBar.thumbProperties.hoverSkin = new Scale9Image(VERTICAL_SCROLL_BAR_THUMB_HOVER_SKIN_TEXTURES);
				scrollBar.thumbProperties.downSkin = new Scale9Image(VERTICAL_SCROLL_BAR_THUMB_DOWN_SKIN_TEXTURES);
				scrollBar.thumbProperties.defaultIcon = new Image(VERTICAL_SCROLL_BAR_THUMB_ICON);
				scrollBar.thumbProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
				scrollBar.thumbProperties.paddingLeft = 4;
			}
			else //horizontal
			{
				scrollBar.thumbProperties.defaultSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_THUMB_UP_SKIN_TEXTURES);
				scrollBar.thumbProperties.hoverSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_THUMB_HOVER_SKIN_TEXTURES);
				scrollBar.thumbProperties.downSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_THUMB_DOWN_SKIN_TEXTURES);
				scrollBar.thumbProperties.defaultIcon = new Image(HORIZONTAL_SCROLL_BAR_THUMB_ICON);
				scrollBar.thumbProperties.verticalAlign = Button.VERTICAL_ALIGN_TOP;
				scrollBar.thumbProperties.paddingTop = 4;
			}
		}

		protected function scrollBarInitializer(scrollBar:ScrollBar):void
		{
			scrollBar.trackLayoutMode = ScrollBar.TRACK_LAYOUT_MODE_SINGLE;

			const decrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
			decrementButtonDisabledIcon.alpha = 0;
			scrollBar.decrementButtonProperties.disabledIcon = decrementButtonDisabledIcon;

			const incrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
			incrementButtonDisabledIcon.alpha = 0;
			scrollBar.incrementButtonProperties.disabledIcon = incrementButtonDisabledIcon;

			if(scrollBar.direction == Slider.DIRECTION_VERTICAL)
			{
				scrollBar.decrementButtonProperties.defaultSkin = new Scale9Image(VERTICAL_SCROLL_BAR_STEP_BUTTON_UP_SKIN_TEXTURES);
				scrollBar.decrementButtonProperties.hoverSkin = new Scale9Image(VERTICAL_SCROLL_BAR_STEP_BUTTON_HOVER_SKIN_TEXTURES);
				scrollBar.decrementButtonProperties.downSkin = new Scale9Image(VERTICAL_SCROLL_BAR_STEP_BUTTON_DOWN_SKIN_TEXTURES);
				scrollBar.decrementButtonProperties.disabledSkin = new Scale9Image(VERTICAL_SCROLL_BAR_STEP_BUTTON_DISABLED_SKIN_TEXTURES);
				scrollBar.decrementButtonProperties.defaultIcon = new Image(VERTICAL_SCROLL_BAR_DECREMENT_BUTTON_ICON_TEXTURE);

				scrollBar.incrementButtonProperties.defaultSkin = new Scale9Image(VERTICAL_SCROLL_BAR_STEP_BUTTON_UP_SKIN_TEXTURES);
				scrollBar.incrementButtonProperties.hoverSkin = new Scale9Image(VERTICAL_SCROLL_BAR_STEP_BUTTON_HOVER_SKIN_TEXTURES);
				scrollBar.incrementButtonProperties.downSkin = new Scale9Image(VERTICAL_SCROLL_BAR_STEP_BUTTON_DOWN_SKIN_TEXTURES);
				scrollBar.incrementButtonProperties.disabledSkin = new Scale9Image(VERTICAL_SCROLL_BAR_STEP_BUTTON_DISABLED_SKIN_TEXTURES);
				scrollBar.incrementButtonProperties.defaultIcon = new Image(VERTICAL_SCROLL_BAR_INCREMENT_BUTTON_ICON_TEXTURE);

				var thumbSkin:Scale9Image = new Scale9Image(VERTICAL_SCROLL_BAR_THUMB_UP_SKIN_TEXTURES);
				thumbSkin.height = thumbSkin.width;
				scrollBar.thumbProperties.defaultSkin = thumbSkin;
				thumbSkin = new Scale9Image(VERTICAL_SCROLL_BAR_THUMB_HOVER_SKIN_TEXTURES);
				thumbSkin.height = thumbSkin.width;
				scrollBar.thumbProperties.hoverSkin = thumbSkin;
				thumbSkin = new Scale9Image(VERTICAL_SCROLL_BAR_THUMB_DOWN_SKIN_TEXTURES);
				thumbSkin.height = thumbSkin.width;
				scrollBar.thumbProperties.downSkin = thumbSkin;
				scrollBar.thumbProperties.defaultIcon = new Image(VERTICAL_SCROLL_BAR_THUMB_ICON);
				scrollBar.thumbProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
				scrollBar.thumbProperties.paddingLeft = 4;

				scrollBar.minimumTrackProperties.defaultSkin = new Scale9Image(VERTICAL_SCROLL_BAR_TRACK_TEXTURES);
			}
			else //horizontal
			{
				scrollBar.decrementButtonProperties.defaultSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_STEP_BUTTON_UP_SKIN_TEXTURES);
				scrollBar.decrementButtonProperties.hoverSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_STEP_BUTTON_HOVER_SKIN_TEXTURES);
				scrollBar.decrementButtonProperties.downSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_STEP_BUTTON_DOWN_SKIN_TEXTURES);
				scrollBar.decrementButtonProperties.disabledSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_STEP_BUTTON_DISABLED_SKIN_TEXTURES);
				scrollBar.decrementButtonProperties.defaultIcon = new Image(HORIZONTAL_SCROLL_BAR_DECREMENT_BUTTON_ICON_TEXTURE);

				scrollBar.incrementButtonProperties.defaultSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_STEP_BUTTON_UP_SKIN_TEXTURES);
				scrollBar.incrementButtonProperties.hoverSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_STEP_BUTTON_HOVER_SKIN_TEXTURES);
				scrollBar.incrementButtonProperties.downSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_STEP_BUTTON_DOWN_SKIN_TEXTURES);
				scrollBar.incrementButtonProperties.disabledSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_STEP_BUTTON_DISABLED_SKIN_TEXTURES);
				scrollBar.incrementButtonProperties.defaultIcon = new Image(HORIZONTAL_SCROLL_BAR_INCREMENT_BUTTON_ICON_TEXTURE);

				thumbSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_THUMB_UP_SKIN_TEXTURES);
				thumbSkin.width = thumbSkin.height;
				scrollBar.thumbProperties.defaultSkin = thumbSkin;
				thumbSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_THUMB_HOVER_SKIN_TEXTURES);
				thumbSkin.width = thumbSkin.height;
				scrollBar.thumbProperties.hoverSkin = thumbSkin;
				thumbSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_THUMB_DOWN_SKIN_TEXTURES);
				thumbSkin.width = thumbSkin.height;
				scrollBar.thumbProperties.downSkin = thumbSkin;
				scrollBar.thumbProperties.defaultIcon = new Image(HORIZONTAL_SCROLL_BAR_THUMB_ICON);
				scrollBar.thumbProperties.verticalAlign = Button.VERTICAL_ALIGN_TOP;
				scrollBar.thumbProperties.paddingTop = 4;

				scrollBar.minimumTrackProperties.defaultSkin = new Scale9Image(HORIZONTAL_SCROLL_BAR_TRACK_TEXTURES);
			}
		}

		protected function textInputInitializer(input:TextInput):void
		{
			input.minWidth = input.minHeight = 22;
			input.paddingTop = input.paddingBottom = 2;
 			input.paddingRight = input.paddingLeft = 4;
			input.stageTextProperties.fontFamily = "Arial";
			input.stageTextProperties.fontSize = 11;
			input.stageTextProperties.color = PRIMARY_TEXT_COLOR;

			input.backgroundSkin = new Scale9Image(TEXT_INPUT_BACKGROUND_SKIN_TEXTURES);
			input.backgroundDisabledSkin = new Scale9Image(TEXT_INPUT_BACKGROUND_DISABLED_SKIN_TEXTURES);
		}

		protected function progressBarInitializer(progress:ProgressBar):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(SIMPLE_BORDER_BACKGROUND_SKIN_TEXTURES);
			backgroundSkin.width = backgroundSkin.height * 30;
			progress.backgroundSkin = backgroundSkin;
			progress.fillSkin = new Image(PROGRESS_BAR_FILL_SKIN_TEXTURE);

			progress.paddingTop = progress.paddingRight = progress.paddingBottom =
				progress.paddingLeft = 1;
		}

		protected function scrollerInitializer(scroller:Scroller):void
		{
			scroller.horizontalScrollBarFactory = horizontalScrollBarFactory;
			scroller.verticalScrollBarFactory = verticalScrollBarFactory;

			scroller.interactionMode = Scroller.INTERACTION_MODE_MOUSE;
			scroller.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_FIXED;
		}

		protected function listInitializer(list:List):void
		{
			list.backgroundSkin = new Scale9Image(SIMPLE_BORDER_BACKGROUND_SKIN_TEXTURES);

			list.paddingTop = list.paddingRight = list.paddingBottom =
				list.paddingLeft = 1;
		}

		protected function pickerListInitializer(list:PickerList):void
		{
			list.popUpContentManager = new DropDownPopUpContentManager();
			list.listProperties.maxHeight = 110;

			list.listProperties.backgroundSkin = new Scale9Image(SIMPLE_BORDER_BACKGROUND_SKIN_TEXTURES);

			list.listProperties.paddingTop = list.listProperties.paddingRight = list.listProperties.paddingBottom =
				list.listProperties.paddingLeft = 1;
		}

		protected function defaultItemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			renderer.defaultSkin = new Image(ITEM_RENDERER_UP_SKIN_TEXTURE);
			renderer.hoverSkin = new Image(ITEM_RENDERER_HOVER_SKIN_TEXTURE);
			renderer.downSkin = new Image(ITEM_RENDERER_SELECTED_UP_SKIN_TEXTURE);
			renderer.defaultSelectedSkin = new Image(ITEM_RENDERER_SELECTED_UP_SKIN_TEXTURE);

			renderer.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;

			renderer.paddingTop = renderer.paddingBottom = 2;
			renderer.paddingRight = renderer.paddingLeft = 6;
			renderer.gap = 2;
			renderer.minWidth = renderer.minHeight = 22;
		}

		protected function defaultHeaderOrFooterRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			renderer.backgroundSkin = new Scale9Image(HEADER_BACKGROUND_SKIN_TEXTURES);
			renderer.backgroundSkin.height = 18;

			renderer.paddingTop = renderer.paddingBottom = 2;
			renderer.paddingRight = renderer.paddingLeft = 6;
			renderer.minWidth = renderer.minHeight = 18;
		}

		protected function calloutInitializer(callout:Callout):void
		{
			callout.backgroundSkin = new Scale9Image(PANEL_BORDER_BACKGROUND_SKIN_TEXTURES);
			const arrowSkin:Quad = new Quad(8, 8, 0xff00ff);
			arrowSkin.alpha = 0;
			callout.topArrowSkin =  callout.rightArrowSkin =  callout.bottomArrowSkin =
				callout.leftArrowSkin = arrowSkin;

			callout.paddingTop = callout.paddingBottom = 6;
			callout.paddingRight = callout.paddingLeft = 10;
		}

		protected function screenHeaderInitializer(header:ScreenHeader):void
		{
			header.backgroundSkin = new Scale9Image(HEADER_BACKGROUND_SKIN_TEXTURES);

			header.titleProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);

			header.paddingTop = header.paddingBottom = 2;
			header.paddingRight = header.paddingLeft = 6;
		}

		protected function root_addedToStageHandler(event:Event):void
		{
			DisplayObject(event.currentTarget).stage.color = BACKGROUND_COLOR;
		}
	}
}
