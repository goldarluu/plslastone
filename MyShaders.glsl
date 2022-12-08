// ***************************
// Shader programs to be used in conjunction with the
//  Phong lighting shaders of EduPhong.glsl
// Are first used with Project #6, Math 155A, Winter 2019
//
// Revision: Feb 23, 2019
// ***************************

// #beginglsl ...  #endglsl mark begining and end of code blocks.
// Syntax for #beginglsl is:
//
//   #beginglsl <shader-type> <shader-code-name>
//
// where <shader-type> is
//      vertexshader or fragmentshader or geometryshader or codeblock,
// and <shader-code-name> is used to compile/link the shader into a 
//      shader program.
// A codeblock is meant to be used as a portion of a larger shader.

// *****************************
// applyTextureMap - code block
//    applyTextureMap() is called after the Phong lighting is calculated.
//        - It returns a vec4 color value, which is used as the final pixel color.
//    Inputs: (all global variables)
//        - nonspecColor and specularColor (global variables, vec3 objects)
//        - theTexCoords (the texture coordinates, a vec2 object)
//    Returns a vec4:
//       - Will be used as the final fragment color
// *****************************
#beginglsl codeblock MyProcTexture
// vec3 nonspecColor;		// These items already declared 
// vec3 specularColor;
// vec2 theTexCoords;

uniform sampler2D theTextureMap;	// An OpenGL texture map

bool InSquareshape( vec2 pos );	// Function prototype

vec4 applyTextureFunction() {
	vec2 wrappedTexCoords = fract(theTexCoords);	// Wrap s,t to [0,1].
	vec4 myColor = vec4(nonspecColor, 1.0f)*texture(theTextureMap, theTexCoords);
	if ( InSquareshape(wrappedTexCoords) ) {	
	    float avgMinus = 1-(myColor.r+myColor.g+myColor.b)/3.0;
		myColor = vec4(avgMinus, avgMinus, avgMinus, 1.0);
		//myColor = mix(myColor, vec4(0.0,0.0,0.0,0.0), 2.0*min(currentTime, 1-currentTime));
	}
	myColor += vec4(specularColor,0.0);
	return myColor;
}


// *******************************
// Recognize the interior of an "Square" shape
//   Input "pos" contains s,t  texture coordinates.
//   Returns: true if inside the "Square" shape.
//            false otherwise
// ******************************
bool InSquareshape( vec2 pos ) {
	float intercept = 0.5; // keeps track of our intercepts 
	//flip = (flip) : false ? true; 

	if (pos.x > .25 && pos.x < 0.5 && (pos.y >= -pos.x + .75) && (pos.y <= pos.x + .25) ) 
		return true; 

	if (pos.x > 0.5 && pos.x < .75 && (pos.y >= pos.x - .25) && (pos.y <= -pos.x + 1.25)) 
		return true; 

	if ( (pos.x >= .25 && pos.x <= .75 ) && (pos.y >= .25 && pos.y <= .75) &&
	!(pos.x > 0.5 && pos.x < .75 && (pos.y >= pos.x - .25) && (pos.y <= -pos.x + 1.25))
	&& !(pos.x > .25 && pos.x < 0.5 && (pos.y >= -pos.x + .75) && (pos.y <= pos.x + .25) ) ) return false; 

	// this line overwrites it 
	if (pos.x > 0 && pos.x < 0.5 && (pos.y >= -pos.x + intercept) && (pos.y <= pos.x + intercept) 
	&& !( (pos.x >= .25 && pos.x <= .75 ) && (pos.y >= .25 && pos.y <= .75) )) 
		return true; 

	if (pos.x > 0.5 && pos.x < 1 && (pos.y >= pos.x - intercept) && (pos.y <= -pos.x+1.5)
	&& !( (pos.x >= .25 && pos.x <= .75 ) && (pos.y >= .25 && pos.y <= .75) ))
		return true; 

	

	return false; 
}


#endglsl
