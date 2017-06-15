#define PROCESSING_COLOR_SHADER

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;

void main() {
    vec3 fogColor = vec3(1.0,1.0,1.0);
    gl_FragColor = vertColor;
    float depth = gl_FragCoord.z / gl_FragCoord.w;
    float fogFactor = smoothstep(600.0, 700.0, depth);
    gl_FragColor = mix(gl_FragColor, vec4(fogColor, gl_FragColor.w), fogFactor);
}

