function point_box_intersect(px,py,x,y,w,h){
	return px>=x and px<=x+w and py>=y and py<=y+h;
}