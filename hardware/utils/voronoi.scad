// (c)2013 Felipe Sanches <juca@members.fsf.org>
// licensed under the terms of the GNU GPL version 3 (or later)

function normalize(v) = v / (sqrt(v[0] * v[0] + v[1] * v[1]));

module voronoi(points, L = 200, thickness = 1, round = 6, nuclei = true) {
	for (p = points) {
		difference() {
			minkowski() {
				intersection_for(p1 = points){
					if (p != p1) {
						angle = 90 + atan2(p[1] - p1[1], p[0] - p1[0]);

						translate((p + p1) / 2 - normalize(p1 - p) * (thickness + round))
						rotate([0, 0, angle])
						translate([-L, -L])
						square([2 * L, L]);
					}
				}
				if (round > 0)
					circle(r = round, $fn = 20);
			}
			if (nuclei)
				translate(p) circle(r = 1, $fn = 20);
		}
	}
}

module random_voronoi(n = 20, nuclei = true, L = 200, thickness = 1, round = 6, min = 0, max = 100, seed = undef, center = false) {
	seed = seed == undef ? rands(0, 100, 1)[0] : seed;
	debug(str("Seed: ", seed));

	// Generate points.
	x = rands(min, max, n, seed);
	y = rands(min, max, n, seed + 1);
	points = [ for (i = [0 : n - 1]) [x[i], y[i]] ];

	// Center Voronoi
	offset_x = center ? -(max-min) / 2 : 0;
	offset_y = center ? -(max-min) / 2 : 0;

	translate([offset_x, offset_y])
		voronoi(points, L = L, thickness = thickness, round = round, nuclei = nuclei);
}

// example with an explicit list of points:
/*
point_set = [
	[0, 0], [30, 0], [20, 10], [50, 20], [15, 30], [85, 30], [35, 30], [12, 60],
	[45, 50], [80, 80], [20, -40], [-20, 20], [-15, 10], [-15, 50]
];
*/
//voronoi(points = point_set, round = 4, nuclei = true);

// example with randomly generated set of points
//random_voronoi(n = 64, round = 6, min = 0, max = 300, seed = 42);
