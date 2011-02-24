package com.godpaper.as3.business.managers
{
	/**
	 * TODO: 		Implement compile-time checking for the singleton pattern
	 * TODO: 		check spelling and grammar of documentation
	 * TODO:		Add getters and setters to check numbers of registered dispatchers/listeners and to ouput lists of such and what they are registered for
	 * TODO: 		Possibly find a way to put the class into "debug" mode where it traces events as it recieves them.
	 * TODO: 		Possibly add some error checking to see if duplicate dispatchers or listeners have already been registered on either list.
	 */
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * Provides a central singleton node for dispatching and listening to events. Having a single node to listen to events
	 * gives us the ability to loosen the coupling between classes.  More specifically, when a class wants to dispatch event,
	 * only the EventManager need be concerned with listening.
	 * <p>
	 * In order to work, EventManager provides a public registerDispactcher method that allows any class or object to announce
	 * itself as one that will be dispatching events.  The event manager will then take a reference to that class, and a list
	 * of events and set itself up as a listener.  When an event is then dispatched, and the EventManager class receives it,
	 * it then proceeds to re-dispatch it to itself.  This becomes useful because any class can access and listen to the
	 * EventManager without having any sort of reference to the actual class that dispatched the event.
	 * <p>
	 * Additionally, this class provides added functionality absent from Adobe's EventDispatcher.  To offer more control over all the events,
	 * this class provides addition methods to remove listeners and dispatchers by type, function object or to remove all.
	 * <p>
	 * With this added functionality of being able to remove large groups of listeners, it also made sense to set up different types
	 * of dispactchers and listeners.  To make the methods that remove all the dispatchers more useful, we now have dispatchers that
	 * can be marked as "permanent."  Permanent dispatchers can survive the methods to remove all dispatchers. Similarly, we have
	 * permanent listeners that can survive methods called to remove all listeners.
	 * <p>
	 * Because this is a singleton class, do not instantiate it by calling the constructor with "new"
	 * If the constructor is called with new, this class will throw a runtime error.
	 *
	 *
	 * @see	EventListenerObject
	 * @see	IRegisteredDispatcher
	 *
	 */
	public class EventManager extends EventDispatcher
	{
		protected static var instance:EventManager;
		protected static var allowInstantiation:Boolean=false;

		protected var dispatchersArray:Array;
		protected var permDispatchers:Array;
		protected var listenerList:Array=[]; //array of EventListenerObjects
		protected var permListeners:Array=[];

		protected var _listenerID:uint=0;
		protected var _dispatcherID:uint=0;

		protected static const MAX_LISTENERS:uint=1000;
		protected static const MAX_DISPATCHERS:uint=1000;

		/**
		 * Constructor.  Throws an error if istantiated with new.  Use EventManager.getInstance() instead of new.
		 *
		 * @throws a ReferenceError indicating you may not instantiate this class via it's constuctor.
		 */
		public function EventManager()
		{
			if (!allowInstantiation)
			{
				throw new ReferenceError("Error: Instantiation failed. Use EventManager.getInstance() instead of new.");
			}
			else
			{
				init();
			}
		}

		protected function init():void
		{
			dispatchersArray=new Array();
			listenerList=new Array();
			permDispatchers=new Array();
			permListeners=new Array();
		}

		/**
		 * Static public function to get the singleton instance of the EventManager
		 * @return		Returns and instance of EventManager. If no instance exists, this method will create one without throwing an error.
		 */
		public static function getInstance():EventManager
		{
			if (instance == null)
			{
				allowInstantiation=true;
				instance=new EventManager();
				allowInstantiation=false;
			}
			return instance;
		}

		/**
		 * Override of Adobe's standard addEventListener function.  The main difference is that this method allows us to store a copy
		 * of the listener so that we can remove it later, in groups, or even remove all at once.
		 *
		 * @param	type				The string name of the event
		 * @param	listener			The function to be triggered by the event
		 * @param	useCapture			Optional. Specifies if the listerner should be triggered durring the capture phase as ooposed to the bubbling phase.
		 * @param	priority			Optional. Integer specifying priority when conflicting listeners are found.
		 * @param	useWeakReference	Optional. If set to true, allows the listener to be garbadge collected. For more on weak references, see Adobe's documentation.
		 *
		 * @see		#removeListenersByType		removeListenersByType
		 * @see		#removeListenersByFunc		removeListenersByFunc
		 * @see		#removeEventListener		removeEventListener
		 *
		 * @throws	a RangeError warning if the number of listeners has exceeded the value in the class constant MAX_LISTENERS (Default is 1000).
		 */
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);

			var listObj:EventListenerObject=new EventListenerObject(_listenerID);

			listObj.func=listener;
			listObj.type=type;
			listObj.useCapt=useCapture;


			listenerList.push(listObj);

			trace("addEventListener list:", listenerList);

			_listenerID++;

			if (_listenerID >= MAX_LISTENERS)
			{
				throw new RangeError(this.toString() + " WARNING: there are over " + MAX_LISTENERS + " listeners registered.");
			}
		}

		/**
		 * Similar to addEventListener, this function will create an event listener that trigger the handler function passed to it.
		 * This method also allows us to store a copy of the reference and, more importantly, prevent it from being removed.
		 * We do this by also overriding removeEventListener to only fire the super's remove when the listener is found on the
		 * regular listener list.
		 *
		 * @param	type				The string name of the event
		 * @param	listener			The function to be triggered by the event
		 * @param	useCapture			Optional. Specifies if the listerner should be triggered durring the capture phase as ooposed to the bubbling phase.
		 * @param	priority			Optional. Integer specifying priority when conflicting listeners are found.
		 * @param	useWeakReference	Optional. If set to true, allows the listener to be garbadge collected. For more on weak references, see Adobe's documentation.
		 *
		 * @see		#removeListenersByType		removeListenersByType
		 * @see		#removeListenersByFunc		removeListenersByFunc
		 * @see		#removeEventListener		removeEventListener
		 *
		 * @throws	a RangeError warning if the number of listeners has exceeded the value in the class constant MAX_LISTENERS (Default is 1000).
		 */
		public function addPermanenttListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);

			var listObj:EventListenerObject=new EventListenerObject(_listenerID);

			listObj.func=listener;
			listObj.type=type;
			listObj.useCapt=useCapture;


			permListeners.push(listObj);


			_listenerID++;

			if (_listenerID >= MAX_LISTENERS)
			{
				throw new RangeError(this.toString() + " WARNING: there are over " + MAX_LISTENERS + " listeners registered.");
			}
		}

		/**
		 * Override of Adobe's standard removeEventListener function.  Because Adobe's EventDispatcher class maintains seperate
		 * lists for listeners set to use the capture phase and the bubbling phase, we must included it as a parameter.
		 * Similarly, because we now have two types of listeners, permanent and regular, we must maintain seperate lists
		 * as well. To remove a permanentListener call the method removePermanentListener.* For more on the caputre and
		 * bubbling phases of events, see Adobe's documentation.
		 *
		 *
		 * @param	type				The string name of the event
		 * @param	listener			The function to be triggered by the event
		 * @param	isPermanent			Optional. Specifies if the listener was marked as permanent when origianlly registered.
		 * @param	useCapture			Optional. Specifies if the listerner should be triggered durring the capture phase as ooposed to the bubbling phase.
		 *
		 * @see		#addEventListener			addEventListener
		 * @see		#removeListenersByType		removeListenersByType
		 * @see		#removeListenersByFunc		removeListenersByFunc
		 * @see		#removePermanentListener	removePermanentListener
		 *
		 */
		public override function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void

		{

			var len:int=listenerList.length;

			for (var i:uint=0; i < len; i++)
			{
				var lo:EventListenerObject=listenerList[i];

				if (lo.type === type && lo.func === listener && lo.useCapt === useCapture)
				{
					super.removeEventListener(lo.type, lo.func, lo.useCapt);
					listenerList.splice(i, 1);
					_listenerID--;
				}
				else
				{
					continue;
				}

			}

		}

		/**
		 * Similar to removeEventListener, this function removes an event listener from the permanent listeners list.
		 *
		 * @param	type				The string name of the event
		 * @param	listener			The function to be triggered by the event
		 * @param	listenerRef			Optional. Specifies the object listening. Useful for trace() actions in debugging.
		 * @param	useCapture			Optional. Specifies if the listerner should be triggered durring the capture phase as ooposed to the bubbling phase.
		 *
		 * @see		#addEventListener			addEventListener
		 * @see		#removeListenersByType		removeListenersByType
		 * @see		#removeListenersByFunc		removeListenersByFunc
		 * @see		#removeEventListener		removeEventListener
		 */
		public function removePermanentListener(type:String, listener:Function, listenerRef:Object=null, useCapture:Boolean=false):void

		{
			var len:int=permListeners.length;

			for (var i:uint=0; i < len; i++)
			{
				var lo:EventListenerObject=permListeners[i];

				if (lo.type === type && lo.func === listener && lo.useCapt === useCapture)
				{
					super.removeEventListener(lo.type, lo.func, lo.useCapt);
					permListeners.splice(i, 1);
					_listenerID--;
				}
				else
				{
					continue;
				}

			}

		}

		/**
		 * Removes all the listeners that have been registered with this manager.  Optionally it
		 * this method can also remove the "permanent" listeners.
		 *
		 * @param	removePermanent 	Optional. Specifies if it should remove permanent as well as regular listeners.
		 *
		 * @see		#addEventListener			addEventListener
		 * @see		#removeListenersByType		removeListenersByType
		 * @see		#removeListenersByFunc		removeListenersByFunc
		 */
		public function removeAllListeners(removePermanent:Boolean=false):void
		{
			var len:int=listenerList.length;

			for (var i:int=len - 1; i >= 0; i--)
			{

				trace("errrrrr", i);
				var lo:EventListenerObject=listenerList[i];
				trace("listenerList$$", listenerList[i]);
				trace("errrrrr", lo);
				trace(lo.type);
				trace(lo.useCapt);
				trace(lo.func);
				//trace ( "listenerList$$",listenerList[i] ) ;
				//_listenerID --;

				try
				{
					removeEventListener(lo.type, lo.func, lo.useCapt);
				}
				catch (e:Error)
				{
					trace("errrrrr", i, e);
				}
			}

			listenerList=new Array();


			if (removePermanent)
			{
				var len2:int=listenerList.length;

				for (var j:int=len2 - 1; j >= 0; j--)
				{
					var plo:EventListenerObject=permListeners[j];

					this.removeEventListener(plo.type, plo.func, plo.useCapt);

				}

				permListeners=new Array();
				_listenerID=0;
			}

		}

		/**
		 * registerDispatcher is a function used to tell the manager to listen for events.
		 * The EventManager will register itself as a listener to any events, even custom events of classes that register via this function.
		 * Custom events must overide the clone() method in order to retain type and custom arguments.
		 *
		 * @param	dispatchingObj 		The class that should be listened to.
		 * @param	makePermanent		Specifies if the dispatcher should be placed in a seperate "permanent" array thus giving us 2 kinds of dipatchers
		 *
		 * @see		#removeAllDispatchers		removeAllDispatchers
		 * @see		#removeDispactchersByType	removeDispactchersByType
		 * @see		#removeDispactchersByObj	removeDispactchersByObj
		 *
		 * @throws	a RangeError warning if the number of dispatchers has exceeded the value in the class constant MAX_DISPACTHERS (Default is 1000).
		 */
		public function registerDispatcher(dispatchingObj:IRegisteredDispatcher, makePermanent:Boolean=false):void
		{

			/**
			 * Get The events
			 * getEvents ( ) is a custom method that must be in any class/obj registering as a dispatcher
			 */


			var eventArray:Array=dispatchingObj.getEvents();


			/**
			 * Add the listeners
			 */

			var len:uint=eventArray.length

			for (var i:uint=0; i < len; i++)
			{
				var dispatcherEventName:String=eventArray[i];

				dispatchingObj.addEventListener(dispatcherEventName, recieveEvent)
			}


			/**
			 * Save a reference in an array and check how many we have.
			 */

			if (makePermanent)
			{
				permDispatchers.push(dispatchingObj);
			}
			else
			{
				dispatchersArray.push(dispatchingObj);
				trace("added dispatcher", dispatchersArray);
			}

			_dispatcherID++;

			if (_dispatcherID >= MAX_DISPATCHERS)
			{
				throw new RangeError(this.toString() + "WARNING: there are over " + MAX_DISPATCHERS + " dispatchers registered.");
			}
		}

		/**
		 * Redispatches any events recieved.
		 * @private
		 */
		protected function recieveEvent(e:Event):void
		{
			trace("recieveEvent ::", e.type);
			dispatchEvent(e);
		}

		/**
		 * Removes all objects that have registered as dispatchers with the EventManager.  This method will cycle through the
		 * dispatcher list and remove itself as a lister to all events for each object in the dispatcher list.
		 *
		 * @param	removePermanent		Optional. Specifies if the method should also remove and dispatchers regeistered with the permanent flag.
		 *
		 * @see		#removeDispactchersByType	removeDispactchersByType
		 * @see		#removeDispactchersByObj	removeDispactchersByObj
		 * @see		#registerDispatcher			registerDispatcher
		 */
		public function removeAllDispatchers(removePermanent:Boolean=false):void
		{

			/**
			 * remove regular dipatchers & reset the list
			 */

			var len:uint=dispatchersArray.length

			for (var i:uint=0; i < len; i++)
			{
				var evtArray:Array=dispatchersArray[i].getEvents();
				var len2:uint=evtArray.length
				var dispatcher:Object=dispatchersArray[i];

				for (var j:uint=0; j < len2; j++)
				{
					var eventName:String=evtArray[j];

					dispatcher.removeEventListener(eventName, recieveEvent);
				}
			}

			dispatchersArray=new Array();
			_dispatcherID=0;

			if (removePermanent)
			{

				/**
				 * remove permanent dipatchers & reset the list
				 */

				var len3:uint=permDispatchers.length

				for (var k:uint=0; k < len3; k++)
				{
					var evtArray2:Array=permDispatchers[k].getEvents();
					var len4:uint=evtArray2.length
					var dispatcherPerm:Object=permDispatchers[k];

					for (var n:uint=0; n < len4; n++)
					{
						var permEventName:String=evtArray2[n];

						dispatcherPerm.removeEventListener(permEventName, recieveEvent);
					}
				}

				permDispatchers=new Array();
			}
		}

		/**
		 * Removes all the dispatchers that have registed with a specified event type. Uses a normal
		 * equality check a == b on the string name of the event.  If found it removes that object completely as a dispatcher
		 * including any other event that object registered to dispatch.  This methos only loops through one list of dispatchers at a time --
		 * either "permamnent" or "regular."  You must call this method twice to search both lists and specify the isPermanent parameter.
		 *
		 * @param	type			The string name of the event such as MouseEvent.CLICK
		 * @param	isPermanent		Optional. Defaults to false. Specifies which list of dispatchers to look through for this type.
		 *
		 * @return	Returns true if a match was found and it's dispatcher was removed, otherwise returns false.
		 *
		 * @see 	#removeDispactchersByObj		removeDispactchersByObj
		 * @see		#removeAllDispatchers			removeAllDispatchers
		 * @see		#registerDispatcher				registerDispatcher
		 */
		public function removeDispactchersByType(type:String, isPermanent:Boolean=false):Boolean
		{
			var matchFound:Boolean=false;
			var arrayToUpdate:Array=isPermanent ? permDispatchers : dispatchersArray;
			var len:int=arrayToUpdate.length;
			trace("%%%%%%%%%%%%%");
			for (var i:int=len - 1; i >= 0; i--)
			{

				trace("iiiiiiiiiiiii", i);
				var evtArray:Array=arrayToUpdate[i].getEvents();


				var len2:uint=evtArray.length
				var dispatcher:IRegisteredDispatcher=arrayToUpdate[i];

				for (var j:uint=0; j < len2; j++)
				{
					var eventName:String=evtArray[j];

					if (eventName == type)
					{
						removeDispactchersByObj(dispatcher, isPermanent);
						matchFound=true;
					}

				}
			}
			return matchFound;
		}

		/**
		 * Removes all dispatchers that match the object passed as a param. Uses a strict equality check a === b
		 * when comparing the param obj to the dispatcher list.  If found it removes that object completely as a dispatcher
		 * including any event that object registered to dispatch.  This methods only loops through one list of dispatchers at a time --
		 * either "permamnent" or "regular."  You must call this method twice to search both lists and specify the isPermanent parameter.
		 *
		 * @param	obj				The object to remove as a dispatcher. Must implement the IRegisteredDispatcher interface.
		 * @param	isPermanent		Optional. Defaults to false. Specifies which list of dispatchers to look through for this type.
		 *
		 * @return	Returns true if a match was found and it's dispatcher was removed, otherwise returns false.
		 *
		 * @see 	#removeDispactchersByType		removeDispactchersByType
		 * @see		#removeAllDispatchers			removeAllDispatchers
		 * @see		#registerDispatcher				registerDispatcher
		 */
		public function removeDispactchersByObj(obj:IRegisteredDispatcher, isPermanent:Boolean=false):Boolean
		{
			trace("removeDispactchersByObj", obj);


			var matchFound:Boolean=false;
			var arrayToUpdate:Array=isPermanent ? permDispatchers : dispatchersArray;
			var len:int=arrayToUpdate.length;

			trace("arrayToUpdate len", dispatchersArray, len);


			for (var i:int=len - 1; i >= 0; i--)
			{
				var evtArray:Array=arrayToUpdate[i].getEvents();
				var len2:int=evtArray.length
				var dispatcher:Object=arrayToUpdate[i];

				trace("dispatcher", i, dispatcher);

				if (dispatcher === obj)
				{
					for (var j:uint=0; j < len2; j++)
					{
						var eventName:String=evtArray[j];

						dispatcher.removeEventListener(eventName, recieveEvent);
					}

					arrayToUpdate.splice(i, 1);
					_dispatcherID--;
					matchFound=true;
				}
				else
				{
					continue;
				}

			}

			return matchFound;
		}

		/**
		 * Removes all listeners of a specified type. Uses a normal equality check a == b on the string name of the event.
		 * This methods only loops through one list of listeners at a time -- either "permamnent" or "regular."
		 * You must call this method twice to search both lists and specify the isPermanent parameter.
		 *
		 * @param	type			The string name of the event such as MouseEvent.CLICK
		 * @param	isPermanent		Optional. Defaults to false. Specifies which list of listeners to look through for this type.
		 *
		 * @return					Returns true if a match was found and the listener was removed, otherwise returns false.
		 *
		 * @see		#addEventListener			addEventListener
		 * @see		#removeListenersByFunc		removeListenersByFunc
		 * @see		#removeEventListener		removeEventListener
		 */
		public function removeListenersByType(type:String, isPermanent:Boolean=false):Boolean
		{
			var matchFound:Boolean=false;
			var arrayToUpdate:Array=isPermanent ? permListeners : listenerList;
			var len:int=arrayToUpdate.length;

			for (var i:uint=0; i < len; i++)
			{
				var lo:EventListenerObject=arrayToUpdate[i];

				if (lo.type == type)
				{
					if (isPermanent)
					{
						this.removePermanentListener(lo.type, lo.func, lo.useCapt);
					}
					else
					{
						this.removeEventListener(lo.type, lo.func, lo.useCapt);
					}
					matchFound=true;

				}
				else
				{
					continue;
				}

			}

			return matchFound;
		}

		/**
		 * Removes all listeners that are set to trigger the specified function. Uses a normal equality check a == b
		 * on the function reference passed to this method against the list of listeners.
		 *
		 * This methods only loops through one list of listeners at a time -- either "permamnent" or "regular."
		 * You must call this method twice to search both lists and specify the isPermanent parameter.
		 *
		 * @param	func					A reference to the function that the listeners that you want to remove are set to trigger
		 * @param	isPermanent
		 * @return
		 *
		 * @see		#addEventListener			addEventListener
		 * @see		#removeListenersByType		removeListenersByType
		 * @see		#removeEventListener		removeEventListener
		 *
		 */
		public function removeListenersByFunc(func:Function, isPermanent:Boolean=false):Boolean
		{


			var matchFound:Boolean=false;
			var arrayToUpdate:Array=isPermanent ? permListeners : listenerList;
			var len:int=arrayToUpdate.length;

			for (var i:int=len - 1; i >= 0; i--)
			{


				var lo:EventListenerObject=arrayToUpdate[i];

				if (lo.func === func)
				{
					if (isPermanent)
					{
						this.removePermanentListener(lo.type, lo.func, lo.useCapt);
					}
					else
					{
						this.removeEventListener(lo.type, lo.func, lo.useCapt);
					}
					matchFound=true;
						//arrayToUpdate.splice ( i , 1 ) ;
				}
				else
				{
					continue;
				}

			}
			return matchFound;
		}

		/**
		 * Lists All dispatchers and listeners currently registerer.
		 * @return	The string list of dispatchers and listeners.
		 * @usage	Pass the return to a trace or logging class.
		 * @example The following code will trace a (possibly long) list of all dispatchers and listeners:
		 * <listing version="3.0" > trace( EventManager.getInstance().listAll() ); </listing>
		 */
		public function listAll():String
		{
			var returnString:String="::::::: Begin list of dispatchers and listeners registered with EventManager :::::::\n";

			returnString+=listDispatchers(true);
			returnString+="\n";

			returnString+=listDispatchers(false);
			returnString+="\n";

			returnString+=listListeners(true);
			returnString+="\n";

			returnString+=listListeners(false);
			returnString+="\n";

			returnString+="::::::: End list of dispatchers and listeners registered with EventManager :::::::\n";

			return returnString;
		}

		public function listDispatchers(listPermanent:Boolean):String
		{
			var isPermString:String=listPermanent ? "Permanent" : "Regular";

			var returnString:String=isPermString + " Dispatchers:\n";

			var matchFound:Boolean=false;
			var arrayToUpdate:Array=listPermanent ? permDispatchers : dispatchersArray;
			var len:int=arrayToUpdate.length;

			for (var i:uint=0; i < len; i++)
			{
				var evtArray:Array=arrayToUpdate[i].getEvents();
				var len2:uint=evtArray.length
				var dispatcher:Object=arrayToUpdate[i];

				returnString+="+ \t" + dispatcher + " [ " + isPermString + " ] ";

				for (var j:uint=0; j < len2; j++)
				{
					var eventName:String=evtArray[j];
					returnString+="\n";
					returnString+="\t\t\t" + eventName;

				}


			}

			returnString+="\n";

			return returnString;
		}


		public function listListeners(listPermanent:Boolean):String
		{
			var isPermString:String=listPermanent ? "Permanent" : "Regular";

			var returnString:String=isPermString + " Listeners:\n";

			var matchFound:Boolean=false;
			var arrayToUpdate:Array=listPermanent ? permListeners : listenerList;
			var len:int=arrayToUpdate.length;

			for (var i:uint=0; i < len; i++)
			{

				var lo:EventListenerObject=arrayToUpdate[i];

				if (isPermString)
				{
					returnString+="+ \t" + lo.type + " \t" + " [ " + isPermString + " ] " + " \t";
				}
				else
				{
					returnString+="+ \t" + lo.type + " \t" + " [ " + isPermString + " ] ";
				}

				returnString+="\n";
			}



			return returnString;
		}

		public function get dispatcherID():uint
		{
			return _dispatcherID;
		}

		public function get listenerID():uint
		{
			return _listenerID;
		}

	}
}

internal class EventListenerObject
{

	protected var _func:Function;
	protected var _type:String;
	protected var _id:uint;
	protected var _useCapt:Boolean;
	protected var _listenerReference:Object;



	public function EventListenerObject(id:uint)
	{
		this._id=id;

	}

	public function valueOf():uint
	{
		return _id;
	}


	//getters
	public function get func():Function
	{
		return _func;
	}

	public function get type():String
	{
		return _type;
	}

	public function get listenerReference():Object
	{
		return _listenerReference;
	}

	public function get id():uint
	{
		return _id;
	}

	public function get useCapt():Boolean
	{
		return _useCapt;
	}



	//setters
	public function set func(value:Function):void
	{
		_func=value;
	}

	public function set type(value:String):void
	{
		_type=value;
	}

	public function set useCapt(value:Boolean):void
	{
		_useCapt=value;
	}

	public function set listenerReference(value:Object):void
	{
		_listenerReference=value;
	}


}
