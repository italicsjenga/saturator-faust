import("stdfaust.lib");
import("aanl.lib");
import("maths.lib");
import("basics.lib");

process = driver : wrapper : aa.hardclip2 : trimmer;

driver(x) = x * drive * squeeze;
trimmer(x) = x * (1 / squeeze);
wrapper(x) = (clipper(x) * fadeamt) + (x * (1 - fadeamt));
clipper(x) = aa.arctan(clipamt * x)/aa.arctan(clipamt);

drive = db2linear(nentry("drive", 0, 0, 1, 0.01) * 20) : si.smoo;
squeeze = db2linear(nentry("squeeze", 0, 0, 1, 0.01) * 20) : si.smoo;
// trim = db2linear((nentry("trim", 0, 0, 1, 0.01) * 20) - 20);

slider_raw = nentry("clipping", 0, 0, 1, 0.01);
slider = (.85*slider_raw)+0.15;
fadeamt = min(20*slider_raw, 1);
clipamt = max(ma.EPSILON, (slider^2)*20);