package com.dungeonizer
{
  public class Vec
  {
    public var x : Number;
    public var y : Number;
    public var z : Number;
    public function Vec(vx : Number, vy : Number, vz : Number)
    {
      x = vx;
      y = vy;
      z = vz;
    }
    public function to_angle() : Number
    {
      return Math.atan2(y, x);
    }
    public function truncate(maxVal : Number) : Vec
    {
      return new Vec(Math.min(x, maxVal), Math.min(y, maxVal), Math.min(z, maxVal));
    }
    public function add(v2 : Vec) : Vec
    {
      return new Vec(x+v2.x, y+v2.y, z+v2.z);
    }
    public function subtract(v2 : Vec) : Vec
    {
      return new Vec(x-v2.x, y-v2.y, z-v2.z);
    }
    public function multiply(v2 : Vec) : Vec
    {
      return new Vec(x*v2.x, y*v2.y, z*v2.z);
    }
    public function multiplyScalar(n : Number) : Vec
    {
      return new Vec(x*n, y*n, z*n);
    }
    public function divide(v2 : Vec) : Vec
    {
      return new Vec(x/v2.x, y/v2.y, z/v2.z);
    }
    public function divideScalar(n : Number) : Vec
    {
      return new Vec(x/n, y/n, z/n);
    }
    public function magnitude() : Number
    {
      return Math.sqrt(x*x+y*y+z*z)
    }
    public function normalize() : Vec
    {
      var mag : Number = magnitude();
      return new Vec(x/mag, y/mag, z/mag);
    }
    public function cross(v2 : Vec) : Vec
    {
      return new Vec(y*v2.z - z * v2.y, z*v2.x - x*v2.z, x*v2.y - y*v2.x);
    }
    public function isNonZero() : Boolean
    {
      return x != 0 || y != 0 || z != 0;
    }
    public function toString() : String
    {
      return "<" + x + "," + y + "," + z + ">";
    }
  }
  
}