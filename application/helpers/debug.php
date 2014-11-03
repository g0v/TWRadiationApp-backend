<?php defined('SYSPATH') OR die('No direct access allowed.');
/**
 * debug helper class.
 * Common functions for debug
 *
 * $Id: valid.php 3917 2009-01-21 03:06:22Z zombor $
 *
 * @package    Ushahidi
 * @category   Helpers
 * @author     Ushahidi Team
 * @copyright  (c) 2008 Ushahidi Team
 * @license    http://www.ushahidi.com/license.html
 */
class debug_Core {
	public static function log_trace() {
		$trace = debug_backtrace ();
		error_log ( '  ====  ' );
		foreach ( $trace as $entry ) {
			if (isset ( $entry ['file'] )) {
				error_log ( substr ( sprintf ( '%s:%s', $entry ['file'], $entry ['line'] ), strlen ( DOCROOT ) ) );
			}
		}
		error_log ( '  ----  ' );
	}
}
