// Dimensions
frame_main_width = 1000;
frame_main_depth = 350;
frame_side_width_rear = 1000;
frame_side_width_front = 700;
frame_side_depth = 300;
frame_height = 400;

leg_width = 30;
leg_depth = 30;

// Positions
rear_corner_leg = [0, -leg_depth, 0];
front_corner_leg = [frame_side_depth, -frame_main_depth, 0];
right_rear_leg = [frame_main_width - leg_width, -leg_depth, 0];
right_front_leg = [frame_main_width - leg_width, -frame_main_depth, 0];
side_rear_leg = [0, -frame_side_width_rear, 0];
side_front_leg = [frame_side_depth, -frame_side_width_front, 0];


// Helpers
function diag_len(a, b) = sqrt(pow(a, 2) + pow(b, 2));

// Components
module leg() {
    color([0, 0, 1])
    cube([leg_width, leg_depth, frame_height]);
}

module horizontal_strut(width) {
    color([1, 0, 0])
    cube([width, leg_depth, leg_width]);
}

module depth_strut(width) {
    rotate([0, 0, -90])
    color([0, 1, 0])
    horizontal_strut(width);
}

module diagonal_strut(width, angle) {
    rotate([0, 0, angle])
    color([1, 1, 0])
    horizontal_strut(width);
}


// Legs
translate(rear_corner_leg) leg();
translate(front_corner_leg) leg();
translate(right_rear_leg) leg();
translate(right_front_leg) leg();
translate(side_rear_leg) leg();
translate(side_front_leg) leg();

// Frame
translate([0, -leg_depth, frame_height]) {
    horizontal_strut(frame_main_width);
}

translate([0, -leg_depth, frame_height/2]) {
    horizontal_strut(frame_main_width);
}

translate([frame_side_depth, -frame_main_depth, frame_height]) {
    horizontal_strut(frame_main_width - frame_side_depth);
}

translate([frame_side_depth, -frame_main_depth, frame_height/2]) {
    horizontal_strut(frame_main_width - frame_side_depth);
}

translate([0, 0, frame_height]) {
    depth_strut(frame_side_width_rear);
}

translate([0, 0, frame_height/2]) {
    depth_strut(frame_side_width_rear);
}

translate([frame_side_depth, -frame_main_depth, frame_height]) {
    depth_strut(frame_side_width_front - frame_main_depth);
}

translate([frame_side_depth, -frame_main_depth, frame_height/2]) {
    depth_strut(frame_side_width_front - frame_main_depth);
}

translate([frame_main_width - leg_width, 0, frame_height]) {
    depth_strut(frame_main_depth);
}

translate([frame_main_width - leg_width, 0, frame_height/2]) {
    depth_strut(frame_main_depth);
}

translate([frame_main_width/2, 0, frame_height]) {
    depth_strut(frame_main_depth);
}

translate([frame_main_width/2, 0, frame_height/2]) {
    depth_strut(frame_main_depth);
}

translate([0, 0, frame_height]) {
    diagonal_strut(
        diag_len(frame_main_depth, frame_side_depth),
        -acos(frame_side_depth/diag_len(frame_main_depth, frame_side_depth))
    );
}

translate([0, 0, frame_height/2]) {
    diagonal_strut(
        diag_len(frame_main_depth, frame_side_depth),
        -acos(frame_side_depth/diag_len(frame_main_depth, frame_side_depth))
    );
}

translate([0, -frame_side_width_rear, frame_height]) {
    diagonal_strut(
        diag_len(frame_side_depth, frame_side_width_rear - frame_side_width_front),
        acos(frame_side_depth/diag_len(frame_side_depth, frame_side_width_rear - frame_side_width_front))
    );
}

translate([0, -frame_side_width_rear, frame_height/2]) {
    diagonal_strut(
        diag_len(frame_side_depth, frame_side_width_rear - frame_side_width_front),
        acos(frame_side_depth/diag_len(frame_side_depth, frame_side_width_rear - frame_side_width_front))
    );
}
