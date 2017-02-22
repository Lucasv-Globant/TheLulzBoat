

/*
// Digitized
// By: Brandon Fogerty
// bfogerty@gmail.com

#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

float random( vec2 p )
{
  return fract( sin( fract( sin( p.x ) ) + p.y) * 42.17563);
}

float worley( vec2 p, float timeSpeed )
{
  float d = 10.0;
  for( int xo = -1; xo <= 1; xo++ )
  {
    for( int yo = -1; yo <= 1; yo++ )
    {
      vec2 test_cell = floor(p) + vec2( xo, yo );

      float f1 = random( test_cell );
      float f2 = random( test_cell + vec2(1.0,83.0) );

      float xp = mix( f1, f2, sin(time*timeSpeed) );
      float yp = mix( f1, f2, cos(time*timeSpeed) );

      vec2 c = test_cell + vec2(xp,yp);

      vec2 cTop = p - c;
      d = min( d, dot(cTop,cTop) );
    }
  }
  return d;
}

float worley2( vec2 p )
{
  float d = 10.0;
  for( int xo = -1; xo <= 1; xo++ )
  {
    for( int yo = -1; yo <= 1; yo++ )
    {
      vec2 test_cell = floor(p) + vec2( xo, yo );

      vec2 c = test_cell;

      vec2 cTop = p - c;
      d = min( d, dot(cTop,cTop) );
    }
  }
  return d;
}


void main( void )
{
  vec2 uv = (gl_FragCoord.xy / resolution.xy) * 2.0 - 1.0;

  float t = worley( gl_FragCoord.xy / 20.0,1. );
  vec3 finalColor = vec3( t,t,0) * 2.0;



  finalColor *= smoothstep(1.0, 0.0, length(uv.y) * 0.5 );
  
  gl_FragColor = vec4( finalColor, 1.0 );
  
}
*/


void main( void )
{

    float time = u_time * .5;
    vec2 sp = gl_FragCoord.xy / size.xy;
    vec2 p = sp * 6.0 - 20.0;
    vec2 i = p;
    float c = 1.0;
    float inten = .05;
    for (int n = 0; n < 5; n++)
    {
        float t = time * (1.0 - (3.5 / float(n+1)));
        i = p + vec2(cos(t - i.x) + sin(t + i.y), sin(t - i.y) + cos(t + i.x));
        c += 1.0/length(vec2(p.x / (sin(i.x+t)/inten),p.y / (cos(i.y+t)/inten)));
    }
    c /= float(5);
    c = 1.5-sqrt(c);
    vec3 colour = vec3(pow(abs(c), 15.0));
    gl_FragColor = vec4(clamp(colour + vec3(0.0, 0.17, 0.3), 0.0, .5), 0.2);

}

