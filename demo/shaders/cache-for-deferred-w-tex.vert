precision highp float;

#pragma glslify: transpose = require('glsl-transpose')
#pragma glslify: inverse = require('glsl-inverse')

attribute vec2 aTexCo;

attribute vec3 
  aPos, 
  aNormal;

uniform mat4 
  uModel,
  uProjection,
  uView;

varying vec2 vTexCo;

varying vec3 
  vNormal,
  vViewPos;

mat3 normalMatrix;

mat4 modelViewMatrix;

vec4 viewPos;

// TODO (abiro) Move normal matrix computation to CPU.
void main() 
{
  modelViewMatrix = uView * uModel;

  normalMatrix = transpose(inverse(mat3(modelViewMatrix)));

  vNormal = normalize(normalMatrix * aNormal);
  
  viewPos = modelViewMatrix * vec4(aPos, 1.0);

  vViewPos = viewPos.xyz;

  vTexCo = aTexCo;

  gl_Position = uProjection * viewPos;
}