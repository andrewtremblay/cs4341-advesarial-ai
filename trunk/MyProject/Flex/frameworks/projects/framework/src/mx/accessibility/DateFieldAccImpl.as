////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2003-2006 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package mx.accessibility
{

import flash.accessibility.Accessibility;
import flash.events.Event;
import mx.controls.DateField;
import mx.core.UIComponent;
import mx.core.mx_internal;

use namespace mx_internal;

/**
 *  DateFieldAccImpl is a subclass of AccessibilityImplementation
 *  which implements accessibility for the DateField class.
 */
public class DateFieldAccImpl extends AccImpl
{
    include "../core/Version.as";

	//--------------------------------------------------------------------------
	//
	//  Class constants
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	private static const EVENT_OBJECT_FOCUS:uint =  0x8005;

	/**
	 *  @private
	 */
	private static const EVENT_OBJECT_SELECTION:uint =  0x8006;

	//--------------------------------------------------------------------------
	//
	//  Class methods
	//
	//--------------------------------------------------------------------------

	/**
	 *  Enables accessibility in the DateField class.
	 * 
	 *  <p>This method is called by application startup code
	 *  that is autogenerated by the MXML compiler.
	 *  Afterwards, when instances of DateField are initialized,
	 *  their <code>accessibilityImplementation</code> property
	 *  will be set to an instance of this class.</p>
	 */
	public static function enableAccessibility():void
	{
		DateField.createAccessibilityImplementation =
			createAccessibilityImplementation;

		DateChooserAccImpl.enableAccessibility();
	}

	/**
	 *  @private
	 *  Creates a DateField's AccessibilityImplementation object.
	 *  This method is called from UIComponent's
	 *  initializeAccessibility() method.
	 */
	mx_internal static function createAccessibilityImplementation(
								component:UIComponent):void
	{
		component.accessibilityImplementation =
			new DateFieldAccImpl(component);
	}

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *  Constructor.
	 *
	 *  @param master The UIComponent instance that this AccImpl instance
	 *  is making accessible.
	 */
	public function DateFieldAccImpl(master:UIComponent)
	{
		super(master);

		role = 0x2e; // ROLE_SYSTEM_COMBOBOX
	}

	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	private var instructionsFlag:Boolean = false;

	//--------------------------------------------------------------------------
	//
	//  Overridden properties: AccImpl
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  eventsToHandle
	//----------------------------------

	/**
	 *  @private
	 *	Array of events that we should listen for from the master component.
	 */
	override protected function get eventsToHandle():Array
	{
		return super.eventsToHandle.concat([ "change", "focusIn", "focusOut", "open", "close" ]);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: AccessibilityImplementation
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 *  IAccessible method for returning the state of the DateField.
	 *  States are predefined for all the components in MSAA.
	 *
	 *  @param childID uint
	 *
	 *  @return State uint
	 */
	override public function get_accState(childID:uint):uint
	{
		return getState(childID);
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden methods: AccImpl
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 *  method for returning the name of the DateField
	 *  should return the selected date with weekday, month and year.
	 *
	 *  @param childID uint
	 *
	 *  @return Name String
	 */
	override protected function getName(childID:uint):String
	{
		var name:String = "Drop Down Calendar, ";
		
		var dateField:DateField = DateField(master);
		
		if (dateField.displayedMonth && !isNaN(dateField.displayedYear))
		{
			name += dateField.monthNames[dateField.displayedMonth] + " " +
					dateField.displayedYear;
		}
		
		var instrString:String = ", to open press control down";
		
		var selDate:Date = dateField.selectedDate;
		if (selDate)
		{
			var tDate:String = "" + selDate.getDate() + " " + 
							   dateField.monthNames[selDate.getMonth()] + " " +
							   selDate.getFullYear();
			
			name = "Drop Down Calendar, " + tDate;
		}

		if (instructionsFlag)
			name += instrString;

		return name;
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden event handlers: AccImpl
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 *  Override the generic event handler.
	 *  All AccImpl must implement this to listen
	 *  for events from its master component. 
	 */
	override protected function eventHandler(event:Event):void
	{
		// Let AccImpl class handle the events
		// that all accessible UIComponents understand.
		$eventHandler(event);

		switch (event.type)
		{
			case "change":
			{
				var childID:uint = 289; // not sure where 289 number has come from
				
				var dateField:DateField = DateField(master);

				// need to check != null for Date
				if (dateField.selectedDate != null)
					childID += dateField.selectedDate.getDate();
				
				Accessibility.sendEvent(master, childID, EVENT_OBJECT_FOCUS);
				Accessibility.sendEvent(master, childID, EVENT_OBJECT_SELECTION);
				break;
			}

			case "close":
			case "focusIn":
			{
				instructionsFlag = true;
				break;
			}

			case "open":
			case "focusOut":
			{
				instructionsFlag = false;
				break;
			}
		}
	}
}

}