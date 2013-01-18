package feathers.themes
{
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Check;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.PickerList;
	import feathers.controls.ProgressBar;
	import feathers.controls.Radio;
	import feathers.controls.ScrollBar;
	import feathers.controls.Scroller;
	import feathers.controls.SimpleScrollBar;
	import feathers.controls.Slider;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleSwitch;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.controls.popups.DropDownPopUpContentManager;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.core.AddedWatcher;
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.display.Image;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.system.DeviceCapabilities;
	import feathers.text.BitmapFontTextFormat;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import feathers.skins.IFeathersTheme;
	import feathers.skins.ImageStateValueSelector;
	import feathers.skins.Scale9ImageStateValueSelector;

	public class AzureTheme extends DisplayListWatcher implements IFeathersTheme
	{
		[Embed(source="/../assets/images/azure.png")]
		protected static const ATLAS_IMAGE:Class;

		[Embed(source="/../assets/images/azure.xml",mimeType="application/octet-stream")]
		protected static const ATLAS_XML:Class;

		protected static const ATLAS:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ATLAS_IMAGE(), false), XML(new ATLAS_XML()));

		protected static const PROGRESS_BAR_SCALE_3_FIRST_REGION:Number = 12;
		protected static const PROGRESS_BAR_SCALE_3_SECOND_REGION:Number = 12;
		protected static const BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(8, 8, 15, 49);
		protected static const SLIDER_FIRST:Number = 16;
		protected static const SLIDER_SECOND:Number = 8;
		protected static const CALLOUT_SCALE_9_GRID:Rectangle = new Rectangle(8, 24, 15, 33);
		protected static const SCROLL_BAR_THUMB_SCALE_9_GRID:Rectangle = new Rectangle(4, 4, 4, 4);

		protected static const BACKGROUND_COLOR:uint = 0x13171a;
		protected static const PRIMARY_TEXT_COLOR:uint = 0xe5e5e5;
		protected static const SELECTED_TEXT_COLOR:uint = 0xffffff;

		protected static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
		protected static const ORIGINAL_DPI_IPAD_RETINA:int = 264;

		protected static const BUTTON_UP_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-up-skin"), BUTTON_SCALE_9_GRID);
		protected static const BUTTON_DOWN_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-down-skin"), BUTTON_SCALE_9_GRID);
		protected static const BUTTON_DISABLED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-disabled-skin"), BUTTON_SCALE_9_GRID);

		protected static const HSLIDER_MINIMUM_TRACK_UP_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("hslider-minimum-track-up-skin"), SLIDER_FIRST, SLIDER_SECOND, Scale3Textures.DIRECTION_HORIZONTAL);
		protected static const HSLIDER_MINIMUM_TRACK_DOWN_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("hslider-minimum-track-down-skin"), SLIDER_FIRST, SLIDER_SECOND, Scale3Textures.DIRECTION_HORIZONTAL);
		protected static const HSLIDER_MINIMUM_TRACK_DISABLED_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("hslider-minimum-track-disabled-skin"), SLIDER_FIRST, SLIDER_SECOND, Scale3Textures.DIRECTION_HORIZONTAL);

		protected static const HSLIDER_MAXIMUM_TRACK_UP_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("hslider-maximum-track-up-skin"), 0, SLIDER_SECOND, Scale3Textures.DIRECTION_HORIZONTAL);
		protected static const HSLIDER_MAXIMUM_TRACK_DOWN_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("hslider-maximum-track-down-skin"), 0, SLIDER_SECOND, Scale3Textures.DIRECTION_HORIZONTAL);
		protected static const HSLIDER_MAXIMUM_TRACK_DISABLED_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("hslider-maximum-track-disabled-skin"), 0, SLIDER_SECOND, Scale3Textures.DIRECTION_HORIZONTAL);

		protected static const VSLIDER_MINIMUM_TRACK_UP_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("vslider-minimum-track-up-skin"), 0, SLIDER_SECOND, Scale3Textures.DIRECTION_VERTICAL);
		protected static const VSLIDER_MINIMUM_TRACK_DOWN_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("vslider-minimum-track-down-skin"), 0, SLIDER_SECOND, Scale3Textures.DIRECTION_VERTICAL);
		protected static const VSLIDER_MINIMUM_TRACK_DISABLED_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("vslider-minimum-track-disabled-skin"), 0, SLIDER_SECOND, Scale3Textures.DIRECTION_VERTICAL);

		protected static const VSLIDER_MAXIMUM_TRACK_UP_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("vslider-maximum-track-up-skin"), SLIDER_FIRST, SLIDER_SECOND, Scale3Textures.DIRECTION_VERTICAL);
		protected static const VSLIDER_MAXIMUM_TRACK_DOWN_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("vslider-maximum-track-down-skin"), SLIDER_FIRST, SLIDER_SECOND, Scale3Textures.DIRECTION_VERTICAL);
		protected static const VSLIDER_MAXIMUM_TRACK_DISABLED_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("vslider-maximum-track-disabled-skin"), SLIDER_FIRST, SLIDER_SECOND, Scale3Textures.DIRECTION_VERTICAL);

		protected static const SLIDER_THUMB_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-thumb-up-skin");
		protected static const SLIDER_THUMB_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-thumb-down-skin");
		protected static const SLIDER_THUMB_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-thumb-disabled-skin");

		protected static const SCROLL_BAR_THUMB_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("simple-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_SCALE_9_GRID);

		protected static const PROGRESS_BAR_BACKGROUND_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("progress-bar-background-skin"), PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, Scale3Textures.DIRECTION_HORIZONTAL);
		protected static const PROGRESS_BAR_BACKGROUND_DISABLED_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("progress-bar-background-disabled-skin"), PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, Scale3Textures.DIRECTION_HORIZONTAL);
		protected static const PROGRESS_BAR_FILL_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("progress-bar-fill-skin"), PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, Scale3Textures.DIRECTION_HORIZONTAL);
		protected static const PROGRESS_BAR_FILL_DISABLED_SKIN_TEXTURES:Scale3Textures = new Scale3Textures(ATLAS.getTexture("progress-bar-fill-disabled-skin"), PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, Scale3Textures.DIRECTION_HORIZONTAL);

		protected static const INSET_BACKGROUND_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("inset-skin"), BUTTON_SCALE_9_GRID);
		protected static const INSET_BACKGROUND_DISABLED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("inset-disabled-skin"), BUTTON_SCALE_9_GRID);

		protected static const PICKER_ICON_TEXTURE:Texture = ATLAS.getTexture("picker-icon");

		protected static const LIST_ITEM_UP_TEXTURE:Texture = ATLAS.getTexture("list-item-up-skin");
		protected static const LIST_ITEM_DOWN_TEXTURE:Texture = ATLAS.getTexture("list-item-down-skin");

		protected static const GROUPED_LIST_HEADER_BACKGROUND_SKIN_TEXTURE:Texture = ATLAS.getTexture("grouped-list-header-background-skin");

		protected static const TOOLBAR_BACKGROUND_SKIN_TEXTURE:Texture = ATLAS.getTexture("toolbar-background-skin");

		protected static const TAB_SELECTED_SKIN_TEXTURE:Texture = ATLAS.getTexture("tab-selected-skin");

		protected static const CALLOUT_BACKGROUND_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("callout-background-skin"), CALLOUT_SCALE_9_GRID);
		protected static const CALLOUT_TOP_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-top-skin");
		protected static const CALLOUT_BOTTOM_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-bottom-skin");
		protected static const CALLOUT_LEFT_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-left-skin");
		protected static const CALLOUT_RIGHT_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-right-skin");

		protected static const CHECK_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("check-up-icon");
		protected static const CHECK_DOWN_ICON_TEXTURE:Texture = ATLAS.getTexture("check-down-icon");
		protected static const CHECK_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("check-disabled-icon");
		protected static const CHECK_SELECTED_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("check-selected-up-icon");
		protected static const CHECK_SELECTED_DOWN_ICON_TEXTURE:Texture = ATLAS.getTexture("check-selected-down-icon");
		protected static const CHECK_SELECTED_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("check-selected-disabled-icon");

		protected static const RADIO_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-up-icon");
		protected static const RADIO_DOWN_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-down-icon");
		protected static const RADIO_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-disabled-icon");
		protected static const RADIO_SELECTED_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-selected-up-icon");
		protected static const RADIO_SELECTED_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-selected-disabled-icon");

		[Embed(source="/../assets/fonts/lato30.fnt",mimeType="application/octet-stream")]
		protected static const ATLAS_FONT_XML:Class;

		protected static const BITMAP_FONT:BitmapFont = new BitmapFont(ATLAS.getTexture("lato30_0"), XML(new ATLAS_FONT_XML()));

		public function AzureTheme(root:DisplayObjectContainer, scaleToDPI:Boolean = true)
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
			this._scaleToDPI = scaleToDPI;
			this.initialize();
		}

		protected var _originalDPI:int;

		public function get originalDPI():int
		{
			return this._originalDPI;
		}

		protected var _scaleToDPI:Boolean;

		public function get scaleToDPI():Boolean
		{
			return this._scaleToDPI;
		}

		protected var _scale:Number;
		protected var _fontSize:int;

		protected function initialize():void
		{
			if(this._scaleToDPI)
			{
				//special case for ipad. should be same pixel size as iphone
				if(Capabilities.screenDPI % (ORIGINAL_DPI_IPAD_RETINA / 2) == 0)
				{
					this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
				}
				else
				{
					this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
				}
			}
			else
			{
				this._originalDPI = Capabilities.screenDPI;
			}
			this._scale = Capabilities.screenDPI / this._originalDPI;

			this._fontSize = 30 * this._scale;

			this.setInitializerForClass(BitmapFontTextRenderer, labelInitializer);
			this.setInitializerForClass(Button, buttonInitializer);
			this.setInitializerForClass(Button, tabInitializer, "foxhole-tabbar-tab");
			this.setInitializerForClass(Button, headerButtonInitializer, "foxhole-header-item");
			this.setInitializerForClass(Button, scrollBarThumbInitializer, "foxhole-simple-scroll-bar-thumb");
			this.setInitializerForClass(Button, sliderThumbInitializer, "foxhole-slider-thumb");
			this.setInitializerForClass(Button, pickerListButtonInitializer, "foxhole-picker-list-button");
			this.setInitializerForClass(Button, toggleSwitchOnTrackInitializer, "foxhole-toggle-switch-on-track");
			this.setInitializerForClass(Button, nothingInitializer, "foxhole-slider-minimum-track");
			this.setInitializerForClass(Button, nothingInitializer, "foxhole-slider-maximum-track");
			this.setInitializerForClass(Slider, sliderInitializer);
			this.setInitializerForClass(SimpleScrollBar, scrollBarInitializer);
			this.setInitializerForClass(Check, checkInitializer);
			this.setInitializerForClass(Radio, radioInitializer);
			this.setInitializerForClass(ToggleSwitch, toggleSwitchInitializer);
			this.setInitializerForClass(DefaultListItemRenderer, itemRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, itemRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, headerOrFooterRendererInitializer);
			this.setInitializerForClass(PickerList, pickerListInitializer);
			this.setInitializerForClass(Header, screenHeaderInitializer);
			this.setInitializerForClass(TextInput, textInputInitializer);
			this.setInitializerForClass(ProgressBar, progressBarInitializer);
			this.setInitializerForClass(Callout, calloutInitializer);
		}

		protected function nothingInitializer(nothing:FeathersControl):void
		{

		}

		protected function labelInitializer(label:BitmapFontTextRenderer):void
		{
			if(label.name)
			{
				return;
			}
			label.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
		}

		protected function buttonInitializer(button:Button):void
		{
			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			skinSelector.defaultValue = BUTTON_UP_SKIN_TEXTURES;
			skinSelector.defaultSelectedValue = BUTTON_DOWN_SKIN_TEXTURES;
			skinSelector.setValueForState(BUTTON_DOWN_SKIN_TEXTURES, Button.STATE_DOWN, false);
			skinSelector.setValueForState(BUTTON_DISABLED_SKIN_TEXTURES, Button.STATE_DISABLED, false);
			skinSelector.imageProperties =
			{
				width: 66 * this._scale,
				height: 66 * this._scale,
				textureScale: this._scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;

			button.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			button.defaultSelectedLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

			button.paddingTop = button.paddingBottom = 8 * this._scale;
			button.paddingLeft = button.paddingRight = 16 * this._scale;
			button.gap = 12 * this._scale;
			button.minWidth = button.minHeight = 66 * this._scale;
		}

		protected function pickerListButtonInitializer(button:Button):void
		{
			//styles for the pickerlist button come from above, and then we're
			//adding a little bit extra.
			this.buttonInitializer(button);

			const pickerListButtonDefaultIcon:Image = new Image(PICKER_ICON_TEXTURE);
			pickerListButtonDefaultIcon.scaleX = pickerListButtonDefaultIcon.scaleY = this._scale;
			button.defaultIcon = pickerListButtonDefaultIcon
			button.gap = Number.POSITIVE_INFINITY; //fill as completely as possible
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			button.iconPosition = Button.ICON_POSITION_RIGHT;
		}

		protected function toggleSwitchOnTrackInitializer(track:Button):void
		{
			const defaultSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURES, this._scale);
			defaultSkin.width = 148 * this._scale;
			defaultSkin.height = 66 * this._scale;
			track.defaultSkin = defaultSkin;
			track.minTouchWidth = track.minTouchHeight = 88 * this._scale;
		}

		protected function scrollBarThumbInitializer(thumb:Button):void
		{
			const scrollBarDefaultSkin:Scale9Image = new Scale9Image(SCROLL_BAR_THUMB_SKIN_TEXTURES, this._scale);
			scrollBarDefaultSkin.width = 8 * this._scale;
			scrollBarDefaultSkin.height = 8 * this._scale;
			thumb.defaultSkin = scrollBarDefaultSkin;
			thumb.minTouchWidth = thumb.minTouchHeight = 12 * this._scale;
		}

		protected function sliderThumbInitializer(thumb:Button):void
		{
			const skinSelector:ImageStateValueSelector = new ImageStateValueSelector();
			skinSelector.defaultValue = SLIDER_THUMB_UP_SKIN_TEXTURE;
			skinSelector.defaultSelectedValue = TAB_SELECTED_SKIN_TEXTURE;
			skinSelector.setValueForState(SLIDER_THUMB_DOWN_SKIN_TEXTURE, Button.STATE_DOWN, false);
			skinSelector.setValueForState(SLIDER_THUMB_DISABLED_SKIN_TEXTURE, Button.STATE_DISABLED, false);
			skinSelector.imageProperties =
			{
				width: 66 * this._scale,
				height: 66 * this._scale
			};
			thumb.stateToSkinFunction = skinSelector.updateValue;

			thumb.minTouchWidth = thumb.minTouchHeight = 88 * this._scale;
		}

		protected function tabInitializer(tab:Button):void
		{
			const skinSelector:ImageStateValueSelector = new ImageStateValueSelector();
			skinSelector.defaultValue = TOOLBAR_BACKGROUND_SKIN_TEXTURE;
			skinSelector.defaultSelectedValue = TAB_SELECTED_SKIN_TEXTURE;
			skinSelector.setValueForState(TAB_SELECTED_SKIN_TEXTURE, Button.STATE_DOWN, false);
			skinSelector.imageProperties =
			{
				width: 88 * this._scale,
				height: 88 * this._scale
			};
			tab.stateToSkinFunction = skinSelector.updateValue;

			tab.minWidth = tab.minHeight = 88 * this._scale;
			tab.minTouchWidth = tab.minTouchHeight = 88 * this._scale;
			tab.paddingTop = tab.paddingRight = tab.paddingBottom =
				tab.paddingLeft = 16 * this._scale;
			tab.gap = 12 * this._scale;
			tab.iconPosition = Button.ICON_POSITION_TOP;

			tab.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			tab.defaultSelectedLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);
		}

		protected function headerButtonInitializer(button:Button):void
		{
			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			skinSelector.defaultValue = BUTTON_UP_SKIN_TEXTURES;
			skinSelector.defaultSelectedValue = BUTTON_DOWN_SKIN_TEXTURES;
			skinSelector.setValueForState(BUTTON_DOWN_SKIN_TEXTURES, Button.STATE_DOWN, false);
			skinSelector.setValueForState(BUTTON_DISABLED_SKIN_TEXTURES, Button.STATE_DISABLED, false);
			skinSelector.imageProperties =
			{
				width: 60 * this._scale,
				height: 60 * this._scale,
				textureScale: this._scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;

			button.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			button.defaultSelectedLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

			button.paddingTop = button.paddingBottom = 8 * this._scale;
			button.paddingLeft = button.paddingRight = 16 * this._scale;
			button.gap = 12 * this._scale;
			button.minWidth = button.minHeight = 60 * this._scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this._scale;
		}

		protected function sliderInitializer(slider:Slider):void
		{
//			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_STRETCH;
			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				var sliderMinimumTrackDefaultSkin:Scale3Image = new Scale3Image(VSLIDER_MINIMUM_TRACK_UP_SKIN_TEXTURES, this._scale);
				sliderMinimumTrackDefaultSkin.width *= this._scale;
				sliderMinimumTrackDefaultSkin.height = 198 * this._scale;
				var sliderMinimumTrackDownSkin:Scale3Image = new Scale3Image(VSLIDER_MINIMUM_TRACK_DOWN_SKIN_TEXTURES, this._scale);
				sliderMinimumTrackDownSkin.width *= this._scale;
				sliderMinimumTrackDownSkin.height = 198 * this._scale;
				var sliderMinimumTrackDisabledSkin:Scale3Image = new Scale3Image(VSLIDER_MINIMUM_TRACK_DISABLED_SKIN_TEXTURES, this._scale);
				sliderMinimumTrackDisabledSkin.width *= this._scale;
				sliderMinimumTrackDisabledSkin.height = 198 * this._scale;
				slider.minimumTrackProperties.defaultSkin = sliderMinimumTrackDefaultSkin;
				slider.minimumTrackProperties.downSkin = sliderMinimumTrackDownSkin;
				slider.minimumTrackProperties.disabledSkin = sliderMinimumTrackDisabledSkin;

				var sliderMaximumTrackDefaultSkin:Scale3Image = new Scale3Image(VSLIDER_MAXIMUM_TRACK_UP_SKIN_TEXTURES, this._scale);
				sliderMaximumTrackDefaultSkin.width *= this._scale;
				sliderMaximumTrackDefaultSkin.height = 198 * this._scale;
				var sliderMaximumTrackDownSkin:Scale3Image = new Scale3Image(VSLIDER_MAXIMUM_TRACK_DOWN_SKIN_TEXTURES, this._scale);
				sliderMaximumTrackDownSkin.width *= this._scale;
				sliderMaximumTrackDownSkin.height = 198 * this._scale;
				var sliderMaximumTrackDisabledSkin:Scale3Image = new Scale3Image(VSLIDER_MAXIMUM_TRACK_DISABLED_SKIN_TEXTURES, this._scale);
				sliderMaximumTrackDisabledSkin.width *= this._scale;
				sliderMaximumTrackDisabledSkin.height = 198 * this._scale;
				slider.maximumTrackProperties.defaultSkin = sliderMaximumTrackDefaultSkin;
				slider.maximumTrackProperties.downSkin = sliderMaximumTrackDownSkin;
				slider.maximumTrackProperties.disabledSkin = sliderMaximumTrackDisabledSkin;
			}
			else //horizontal
			{
				sliderMinimumTrackDefaultSkin = new Scale3Image(HSLIDER_MINIMUM_TRACK_UP_SKIN_TEXTURES, this._scale);
				sliderMinimumTrackDefaultSkin.width = 198 * this._scale;
				sliderMinimumTrackDefaultSkin.height *= this._scale;
				sliderMinimumTrackDownSkin = new Scale3Image(HSLIDER_MINIMUM_TRACK_DOWN_SKIN_TEXTURES, this._scale);
				sliderMinimumTrackDownSkin.width = 198 * this._scale;
				sliderMinimumTrackDownSkin.height *= this._scale;
				sliderMinimumTrackDisabledSkin = new Scale3Image(HSLIDER_MINIMUM_TRACK_DISABLED_SKIN_TEXTURES, this._scale);
				sliderMinimumTrackDisabledSkin.width = 198 * this._scale;
				sliderMinimumTrackDisabledSkin.height *= this._scale;
				slider.minimumTrackProperties.defaultSkin = sliderMinimumTrackDefaultSkin;
				slider.minimumTrackProperties.downSkin = sliderMinimumTrackDownSkin;
				slider.minimumTrackProperties.disabledSkin = sliderMinimumTrackDisabledSkin;

				sliderMaximumTrackDefaultSkin = new Scale3Image(HSLIDER_MAXIMUM_TRACK_UP_SKIN_TEXTURES, this._scale);
				sliderMaximumTrackDefaultSkin.width = 198 * this._scale;
				sliderMaximumTrackDefaultSkin.height *= this._scale;
				sliderMaximumTrackDownSkin = new Scale3Image(HSLIDER_MAXIMUM_TRACK_DOWN_SKIN_TEXTURES, this._scale);
				sliderMaximumTrackDownSkin.width = 198 * this._scale;
				sliderMaximumTrackDownSkin.height *= this._scale;
				sliderMaximumTrackDisabledSkin = new Scale3Image(HSLIDER_MAXIMUM_TRACK_DISABLED_SKIN_TEXTURES, this._scale);
				sliderMaximumTrackDisabledSkin.width = 198 * this._scale;
				sliderMaximumTrackDisabledSkin.height *= this._scale;
				slider.maximumTrackProperties.defaultSkin = sliderMaximumTrackDefaultSkin;
				slider.maximumTrackProperties.downSkin = sliderMaximumTrackDownSkin;
				slider.maximumTrackProperties.disabledSkin = sliderMaximumTrackDisabledSkin;
			}
		}

		protected function scrollBarInitializer(scrollBar:SimpleScrollBar):void
		{
			scrollBar.paddingTop = scrollBar.paddingRight = scrollBar.paddingBottom =
				scrollBar.paddingLeft = 2 * this._scale;
		}

		protected function checkInitializer(check:Check):void
		{
			const iconSelector:ImageStateValueSelector = new ImageStateValueSelector();
			iconSelector.defaultValue = CHECK_UP_ICON_TEXTURE;
			iconSelector.defaultSelectedValue = CHECK_SELECTED_UP_ICON_TEXTURE;
			iconSelector.setValueForState(CHECK_DOWN_ICON_TEXTURE, Button.STATE_DOWN, false);
			iconSelector.setValueForState(CHECK_DISABLED_ICON_TEXTURE, Button.STATE_DISABLED, false);
			iconSelector.setValueForState(CHECK_SELECTED_DOWN_ICON_TEXTURE, Button.STATE_DOWN, true);
			iconSelector.setValueForState(CHECK_SELECTED_DISABLED_ICON_TEXTURE, Button.STATE_DISABLED, true);
			iconSelector.imageProperties =
			{
				scaleX: this._scale,
				scaleY: this._scale
			};
			check.stateToIconFunction = iconSelector.updateValue;

			check.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			check.defaultSelectedLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

			check.minTouchWidth = check.minTouchHeight = 88 * this._scale;
			check.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			check.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
		}

		protected function radioInitializer(radio:Radio):void
		{
			const iconSelector:ImageStateValueSelector = new ImageStateValueSelector();
			iconSelector.defaultValue = RADIO_UP_ICON_TEXTURE;
			iconSelector.defaultSelectedValue = RADIO_SELECTED_UP_ICON_TEXTURE;
			iconSelector.setValueForState(RADIO_DOWN_ICON_TEXTURE, Button.STATE_DOWN, false);
			iconSelector.setValueForState(RADIO_DISABLED_ICON_TEXTURE, Button.STATE_DISABLED, false);
			iconSelector.setValueForState(RADIO_SELECTED_DISABLED_ICON_TEXTURE, Button.STATE_DISABLED, true);
			iconSelector.imageProperties =
			{
				scaleX: this._scale,
				scaleY: this._scale
			};
			radio.stateToIconFunction = iconSelector.updateValue;

			radio.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			radio.defaultSelectedLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

			radio.minTouchWidth = radio.minTouchHeight = 88 * this._scale;
			radio.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			radio.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
		}

		protected function toggleSwitchInitializer(toggleSwitch:ToggleSwitch):void
		{
			toggleSwitch.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;

			toggleSwitch.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			toggleSwitch.onLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);
		}

		protected function itemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			const skinSelector:ImageStateValueSelector = new ImageStateValueSelector();
			skinSelector.defaultValue = LIST_ITEM_UP_TEXTURE;
			skinSelector.defaultSelectedValue = LIST_ITEM_DOWN_TEXTURE;
			skinSelector.setValueForState(LIST_ITEM_DOWN_TEXTURE, Button.STATE_DOWN, false);
			skinSelector.imageProperties =
			{
				width: 88 * this._scale,
				height: 88 * this._scale,
				blendMode: BlendMode.NONE
			};
			renderer.stateToSkinFunction = skinSelector.updateValue;

			renderer.paddingTop = renderer.paddingBottom = 11 * this._scale;
			renderer.paddingLeft = renderer.paddingRight = 20 * this._scale;
			renderer.minWidth = 88 * this._scale;
			renderer.minHeight = 88 * this._scale;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;

			renderer.defaultLabelProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
		}

		protected function headerOrFooterRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			const backgroundSkin:Image = new Image(GROUPED_LIST_HEADER_BACKGROUND_SKIN_TEXTURE);
			backgroundSkin.width = 44 * this._scale;
			backgroundSkin.height = 44 * this._scale;
			renderer.backgroundSkin = backgroundSkin;

			renderer.paddingTop = renderer.paddingBottom = 9 * this._scale;
			renderer.paddingLeft = renderer.paddingRight = 16 * this._scale;
			renderer.minWidth = renderer.minHeight = 44 * this._scale;
		}

		protected function pickerListInitializer(list:PickerList):void
		{
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				list.popUpContentManager = new CalloutPopUpContentManager();
			}
			else
			{
				const centerStage:VerticalCenteredPopUpContentManager = new VerticalCenteredPopUpContentManager();
				centerStage.marginTop = centerStage.marginRight = centerStage.marginBottom =
					centerStage.marginLeft = 16 * this._scale;
				list.popUpContentManager = centerStage;
			}

			const layout:VerticalLayout = new VerticalLayout();
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_BOTTOM;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			layout.useVirtualLayout = true;
			layout.gap = 0;
			layout.paddingTop = layout.paddingRight = layout.paddingBottom =
				layout.paddingLeft = 0;
			list.listProperties.layout = layout;

			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				list.listProperties.minWidth = 264 * this._scale;
				list.listProperties.maxHeight = 352 * this._scale;
			}
			else
			{
				const backgroundSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURES, this._scale);
				backgroundSkin.width = 20 * this._scale;
				backgroundSkin.height = 20 * this._scale;
				list.listProperties.backgroundSkin = backgroundSkin;
				list.listProperties.paddingTop = list.listProperties.paddingRight =
					list.listProperties.paddingBottom = list.listProperties.paddingLeft = 8 * this._scale;
			}
		}

		protected function screenHeaderInitializer(header:Header):void
		{
			const backgroundSkin:Image = new Image(TOOLBAR_BACKGROUND_SKIN_TEXTURE);
			backgroundSkin.width = 88 * this._scale;
			backgroundSkin.height = 88 * this._scale;
			backgroundSkin.blendMode = BlendMode.NONE;
			header.backgroundSkin = backgroundSkin;
			header.titleProperties.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			header.paddingTop = header.paddingRight = header.paddingBottom =
				header.paddingLeft = 14 * this._scale;
			header.minHeight = 88 * this._scale;
		}

		protected function textInputInitializer(input:TextInput):void
		{
			input.minWidth = input.minHeight = 66 * this._scale;
			input.minTouchWidth = input.minTouchHeight = 66 * this._scale;
			input.paddingTop = input.paddingBottom = 14 * this._scale;
			input.paddingLeft = input.paddingRight = 16 * this._scale;
//			input.stageTextProperties.fontFamily = "Helvetica";
//			input.stageTextProperties.fontSize = 30 * this._scale;
//			input.stageTextProperties.color = 0xffffff;

			const backgroundSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURES, this._scale);
			backgroundSkin.width = 264 * this._scale;
			backgroundSkin.height = 66 * this._scale;
			input.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_DISABLED_SKIN_TEXTURES, this._scale);
			backgroundDisabledSkin.width = 264 * this._scale;
			backgroundDisabledSkin.height = 66 * this._scale;
			input.backgroundDisabledSkin = backgroundDisabledSkin;
		}

		protected function progressBarInitializer(progress:ProgressBar):void
		{
			const backgroundSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_BACKGROUND_SKIN_TEXTURES, this._scale);
			backgroundSkin.width = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 264 : 24) * this._scale;
			backgroundSkin.height = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 24 : 264) * this._scale;
			progress.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_BACKGROUND_DISABLED_SKIN_TEXTURES, this._scale);
			backgroundDisabledSkin.width = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 264 : 24) * this._scale;
			backgroundDisabledSkin.height = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 24 : 264) * this._scale;
			progress.backgroundDisabledSkin = backgroundDisabledSkin;

			const fillSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_FILL_SKIN_TEXTURES, this._scale);
			fillSkin.width = 24 * this._scale;
			fillSkin.height = 24 * this._scale;
			progress.fillSkin = fillSkin;

			const fillDisabledSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_FILL_DISABLED_SKIN_TEXTURES, this._scale);
			fillDisabledSkin.width = 24 * this._scale;
			fillDisabledSkin.height = 24 * this._scale;
			progress.fillDisabledSkin = fillDisabledSkin;
		}

		protected function calloutInitializer(callout:Callout):void
		{
			callout.paddingTop = callout.paddingRight = callout.paddingBottom =
				callout.paddingLeft = 16 * this._scale;

			const backgroundSkin:Scale9Image = new Scale9Image(CALLOUT_BACKGROUND_SKIN_TEXTURES, this._scale);
			backgroundSkin.width = 48 * this._scale;
			backgroundSkin.height = 48 * this._scale;
			callout.backgroundSkin = backgroundSkin;

			const topArrowSkin:Image = new Image(CALLOUT_TOP_ARROW_SKIN_TEXTURE);
			topArrowSkin.scaleX = topArrowSkin.scaleY = this._scale;
			callout.topArrowSkin = topArrowSkin;
			callout.topArrowGap = 0 * this._scale;

			const bottomArrowSkin:Image = new Image(CALLOUT_BOTTOM_ARROW_SKIN_TEXTURE);
			bottomArrowSkin.scaleX = bottomArrowSkin.scaleY = this._scale;
			callout.bottomArrowSkin = bottomArrowSkin;
			callout.bottomArrowGap = -1 * this._scale;

			const leftArrowSkin:Image = new Image(CALLOUT_LEFT_ARROW_SKIN_TEXTURE);
			leftArrowSkin.scaleX = leftArrowSkin.scaleY = this._scale;
			callout.leftArrowSkin = leftArrowSkin;
			callout.leftArrowGap = 0 * this._scale;

			const rightArrowSkin:Image = new Image(CALLOUT_RIGHT_ARROW_SKIN_TEXTURE);
			rightArrowSkin.scaleX = rightArrowSkin.scaleY = this._scale;
			callout.rightArrowSkin = rightArrowSkin;
			callout.rightArrowGap = -1 * this._scale;
		}

		protected function root_addedToStageHandler(event:Event):void
		{
			DisplayObject(event.currentTarget).stage.color = BACKGROUND_COLOR;
		}

	}
}