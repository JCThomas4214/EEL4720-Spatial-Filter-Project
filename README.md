<html><body>
<h1>EEL4720 Semester Project</h1>
<h2>Introduction</h2>
<p>In this project we take a simple image processing application and accelerate it using Xilinx Evaluation Zedboard-7020. We parallelize the application concept into one applicable on hardware in a pipeline fashion.<p>
<p>	The high pass spatial filter is the image processing application we choose to demonstrate. This filter will attenuate the high frequencies in the image and output the image in the lower frequency. If we were to work with a 64 by 64 pixel image, the traditional application would take in nine of these pixels, three from row zero, three from the row one, and three from the row two. Imagine this is a 3 by 3 matrix, the center pixel will be multiplied by nine and the remaining will be multiplied by negative one. From here it then sums these products and then divides it by nine. If this output is greater than zero, it will be stored, while if it is less than, zero will be stored. The storage location will correspond to the center pixel in the 3 by 3 matrix. This will be repeated 4096 times and each time will take multiple clocks on a traditional processor.<p>
<p>	We can accelerate this by modeling each phase of the filter in a datapath. The multiplication phase can be done in one clock cycle if we implement individual multipliers that take in each pixels. From here, simple eight bit adders can be used to sum the outputs of these multipliers. After a latency of four, we would have this summation. A divider with a one clock latency can then be included that takes this summation and divide it by nine. Then a comparator with a one clock latency can be included that takes this number and outputs it if it is greater than zero or output zero if not.
This datapath, in total, has a latency of seven clock cycles to output one processed pixel, but image data can be fed into this datapath every clock cycle, so after the initial latency we would see a processed pixel every clock cycle until all 4096 pixels are processed. Taking a total of 4125 clock cycles (pixel count plus initial latency) to process one 64 by 64 image.<p>
<p>	Now imagine implementing this datapath eight time. All eight would take in a total of thirty pixels each clock cycle (9 pixels for one iteration + 3*(number of extra datapaths)) and output eight processed pixels every clock cycle. This would take a total of 512 clock cycles plus the initial latency to finish processing a 64 by 64 image.</p>

<h2>Team members</h2>
<ul style="list-style-type:square">
	<li>Jason Lewis (<a href="https://github.com/Jason-LewisG">Jason-LewisG</a>)</li>
	<li>Jonathan Ganyer (<a href="https://github.com/necrostar">necrostar</a>)</li>
</ul>
<h2>Languages</h2>
<p>VHDL, and C</p>
<h2>Tech Stack</h2>
<p>Xilinx tools (PlanAhead, ISE Design Suite, ISIM), Zync-7020 ZED board</p>
</body></html>
