///@desc raycast(x, y, dir, range, obj);
///@arg x
///@arg y
///@arg dir
///@arg range
///@arg obj
function raycast() {

	/*
		Shoot out a ray which travels a certain distance until it collides with something.
		The longer the range, the bigger the toll on your performance, try to keep it as small as possible.
	
		x:		the x position to start the ray from
		y:		the y position to start the ray from
		dir:	the direction the ray travels
		range:	how many pixels the ray travels
		obj:	what object to check for collisions (usually just set to 'all' unless you really need it specific)
	
		Returns a DS Map with these values:
		"x":				 the x position that the ray ended
		"y":				 the y position that the ray ended
		"x_origin":			 the x position that the ray started
		"y_origin":			 the y position that the ray started
		"obj":				 the object the ray collided with or noone
		"distance":			 the distance in pixels between the start of the ray and the end of the ray
							 (distance just equals the range argument if there was no collision)
	
	*/

	var _x, _y, _dir, _range, _xA, _yA, _rangeCount, _objToCollide;
	_x = argument[0];
	_y = argument[1];
	_dir = argument[2];
	_range = argument[3];
	_objToCollide = argument[4];

	var _list, _col;
	_list = ds_map_create();

	ds_map_add(_list, "distance",	 _range);
	ds_map_add(_list, "x",			 _x + lengthdir_x(_range, _dir));
	ds_map_add(_list, "y",			 _y + lengthdir_y(_range, _dir));
	ds_map_add(_list, "x_origin",	 _x);
	ds_map_add(_list, "y_origin",	 _y);


	_col = collision_line(_x, _y, _x + lengthdir_x(_range, _dir), _y + lengthdir_y(_range, _dir), _objToCollide, true, true);

	if (_col)
	{
		_xA = 0;
		_yA = 0;
		_rangeCount = 1;

		while ((!collision_line(_x, _y, _x + _xA, _y + _yA, _objToCollide, true, true)) && (_rangeCount < _range))
		{
		    _xA = lengthdir_x(_rangeCount, _dir);
		    _yA = lengthdir_y(_rangeCount, _dir);
	
			_rangeCount++;
		}

		ds_map_replace(_list, "distance",		 _rangeCount);
		ds_map_replace(_list, "x",				 _x + _xA);
		ds_map_replace(_list, "y",				 _y + _yA);
		ds_map_replace(_list, "x_origin",		 _x);
		ds_map_replace(_list, "y_origin",		 _y);


		_col = collision_line(_x, _y, _x+_xA, _y+_yA, _objToCollide, true, true);
	
	}
	
	switch (_col)
	{
		default:
			var _obj;
			_obj = _col;
		
			ds_map_add(_list, "obj", _obj);
			break;
	
		case noone:
			ds_map_add(_list, "obj", noone);
			break;
	}

	return _list;

	ds_map_destroy(_list);
	_list = undefined;


}
