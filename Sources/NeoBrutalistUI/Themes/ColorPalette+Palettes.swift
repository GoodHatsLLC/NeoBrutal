import SwiftUI

extension Palette {

  public static var paper: Palette {
    Palette(
      primary: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
      secondary: #colorLiteral(
        red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1),
      highlight: #colorLiteral(
        red: 0.8941176471, green: 0.8941176471, blue: 0.8941176471, alpha: 1),
    )
  }

  public static var bubbleAccent: Palette {
    Palette(
      primary: #colorLiteral(red: 1, green: 0.4666666667, blue: 0.6588235294, alpha: 1),
      secondary: #colorLiteral(red: 1, green: 0.6666666667, blue: 0.7843137255, alpha: 1),
      highlight: #colorLiteral(red: 0.3725490196, green: 0.5529411765, blue: 1, alpha: 1),
    )
  }

  public static var midnight: Palette {
    Palette(
      primary: #colorLiteral(red: 0.031372549, green: 0.0549019608, blue: 0.1215686275, alpha: 1),
      secondary: #colorLiteral(red: 0.062745098, green: 0.1098039216, blue: 0.2078431373, alpha: 1),
      highlight: #colorLiteral(red: 0.1803921569, green: 0.8588235294, blue: 1, alpha: 1),
    )
  }

  public static var graphite: Palette {
    Palette(
      primary: #colorLiteral(red: 0.1176470588, green: 0.1803921569, blue: 0.2823529412, alpha: 1),
      secondary: #colorLiteral(
        red: 0.1843137255, green: 0.2745098039, blue: 0.4078431373, alpha: 1),
      highlight: #colorLiteral(red: 0.5568627451, green: 0.7254901961, blue: 1, alpha: 1),
    )
  }

  public static var bone: Palette {
    Palette(
      primary: #colorLiteral(red: 0.937254902, green: 0.9254901961, blue: 0.8705882353, alpha: 1),
      secondary: #colorLiteral(
        red: 0.8666666667, green: 0.8509803922, blue: 0.7960784314, alpha: 1),
      highlight: #colorLiteral(red: 1, green: 0.768627451, blue: 0, alpha: 1),
    )
  }

  public static var concrete: Palette {
    Palette(
      primary: #colorLiteral(red: 0.8509803922, green: 0.862745098, blue: 0.8862745098, alpha: 1),
      secondary: #colorLiteral(
        red: 0.7411764706, green: 0.7568627451, blue: 0.7882352941, alpha: 1),
      highlight: #colorLiteral(red: 0.2901960784, green: 0.3450980392, blue: 0.4, alpha: 0.35),
    )
  }

  public static var charcoal: Palette {
    Palette(
      primary: #colorLiteral(red: 0.0980392157, green: 0.1019607843, blue: 0.1333333333, alpha: 1),
      secondary: #colorLiteral(
        red: 0.1411764706, green: 0.1490196078, blue: 0.1882352941, alpha: 1),
      highlight: #colorLiteral(
        red: 0.3058823529, green: 0.9333333333, blue: 0.7058823529, alpha: 1),
    )
  }

  public static var electricBlue: Palette {
    Palette(
      primary: #colorLiteral(red: 0.2509803922, green: 0.5215686275, blue: 1, alpha: 1),
      secondary: #colorLiteral(red: 0.1607843137, green: 0.4, blue: 0.9647058824, alpha: 1),
      highlight: #colorLiteral(red: 0.2196078431, green: 1, blue: 0.831372549, alpha: 1),
    )
  }

  public static var sherbet: Palette {
    Palette(
      primary: #colorLiteral(red: 1, green: 0.8588235294, blue: 0.8039215686, alpha: 1),
      secondary: #colorLiteral(red: 1, green: 0.7764705882, blue: 0.7254901961, alpha: 1),
      highlight: #colorLiteral(red: 1, green: 0.6117647059, blue: 0.6784313725, alpha: 1),
    )
  }

  public static var magenta: Palette {
    Palette(
      primary: #colorLiteral(red: 0.8392156863, green: 0.1411764706, blue: 0.6117647059, alpha: 1),
      secondary: #colorLiteral(red: 1, green: 0.2196078431, blue: 0.7254901961, alpha: 1),
      highlight: #colorLiteral(red: 1, green: 0.9529411765, blue: 0, alpha: 1),
    )
  }

  public static var emeraldPulse: Palette {
    Palette(
      primary: #colorLiteral(red: 0.3058823529, green: 0.9254901961, blue: 0.7411764706, alpha: 1),
      secondary: #colorLiteral(red: 0.1882352941, green: 0.8, blue: 0.6117647059, alpha: 1),
      highlight: #colorLiteral(red: 0.7058823529, green: 1, blue: 0.8941176471, alpha: 1),
    )
  }

  public static var morningMist: Palette {
    Palette(
      primary: #colorLiteral(red: 0.9882352941, green: 0.968627451, blue: 0.9294117647, alpha: 1),
      secondary: #colorLiteral(
        red: 0.9490196078, green: 0.9176470588, blue: 0.8588235294, alpha: 1),
      highlight: #colorLiteral(red: 1, green: 0.831372549, blue: 0.5647058824, alpha: 1),
    )
  }

  public static var pastelSky: Palette {
    Palette(
      primary: #colorLiteral(red: 0.9529411765, green: 0.968627451, blue: 1, alpha: 1),
      secondary: #colorLiteral(
        red: 0.8862745098, green: 0.9176470588, blue: 0.9882352941, alpha: 1),
      highlight: #colorLiteral(red: 0.7215686275, green: 0.8196078431, blue: 1, alpha: 1),
    )
  }

  public static var citrusSpark: Palette {
    Palette(
      primary: #colorLiteral(red: 1, green: 0.8117647059, blue: 0.3764705882, alpha: 1),
      secondary: #colorLiteral(red: 1, green: 0.6784313725, blue: 0.2666666667, alpha: 1),
      highlight: #colorLiteral(red: 1, green: 0.4, blue: 0.5725490196, alpha: 1),
    )
  }

  public static var sunburst: Palette {
    Palette(
      primary: #colorLiteral(red: 1, green: 0.6156862745, blue: 0.1764705882, alpha: 1),
      secondary: #colorLiteral(red: 1, green: 0.4, blue: 0.5019607843, alpha: 1),
      highlight: #colorLiteral(red: 0, green: 0.7843137255, blue: 0.3764705882, alpha: 1),
    )
  }

  public static var abyss: Palette {
    Palette(
      primary: #colorLiteral(red: 0.0392156863, green: 0.0588235294, blue: 0.1254901961, alpha: 1),
      secondary: #colorLiteral(
        red: 0.0862745098, green: 0.1176470588, blue: 0.2156862745, alpha: 1),
      highlight: #colorLiteral(red: 0.4235294118, green: 0.9254901961, blue: 1, alpha: 1),
    )
  }

  public static var plasmaBlue: Palette {
    Palette(
      primary: #colorLiteral(red: 0.2509803922, green: 0.7607843137, blue: 0.9215686275, alpha: 1),
      secondary: #colorLiteral(
        red: 0.1647058824, green: 0.4509803922, blue: 0.9607843137, alpha: 1),
      highlight: #colorLiteral(red: 0.3725490196, green: 1, blue: 0.9176470588, alpha: 1),
    )
  }

  public static var violetNight: Palette {
    Palette(
      primary: #colorLiteral(red: 0.1294117647, green: 0.0705882353, blue: 0.1882352941, alpha: 1),
      secondary: #colorLiteral(
        red: 0.2117647059, green: 0.1254901961, blue: 0.2980392157, alpha: 1),
      highlight: #colorLiteral(red: 0.5333333333, green: 0.3058823529, blue: 1, alpha: 1),
    )
  }

  public static var infraSignal: Palette {
    Palette(
      primary: #colorLiteral(red: 1, green: 0.2509803922, blue: 0.4666666667, alpha: 1),
      secondary: #colorLiteral(
        red: 0.8392156863, green: 0.1764705882, blue: 0.6823529412, alpha: 1),
      highlight: #colorLiteral(red: 1, green: 0.8196078431, blue: 0.4078431373, alpha: 1),
    )
  }

  public static var desert: Palette {
    Palette(
      primary: #colorLiteral(red: 0.9490196078, green: 0.9176470588, blue: 0.8588235294, alpha: 1),
      secondary: #colorLiteral(
        red: 0.8666666667, green: 0.8509803922, blue: 0.7960784314, alpha: 1),
      highlight: #colorLiteral(red: 1, green: 0.768627451, blue: 0, alpha: 1),
    )
  }

  public static var jungle: Palette {
    Palette(
      primary: #colorLiteral(red: 0.1098039216, green: 0.2039215686, blue: 0.1568627451, alpha: 1),
      secondary: #colorLiteral(
        red: 0.1568627451, green: 0.3058823529, blue: 0.2274509804, alpha: 1),
      highlight: #colorLiteral(red: 0.5019607843, green: 1, blue: 0.7529411765, alpha: 1),
    )
  }

  public static var crimsonFury: Palette {
    Palette(
      primary: #colorLiteral(red: 0.862745098, green: 0.1490196078, blue: 0.1490196078, alpha: 1),
      secondary: #colorLiteral(
        red: 0.7254901961, green: 0.1098039216, blue: 0.1098039216, alpha: 1),
      highlight: #colorLiteral(red: 1, green: 0.3215686275, blue: 0.3215686275, alpha: 1),
    )
  }

  public static var breakIdeasBackground: Palette {
    Palette(
      primary: #colorLiteral(red: 0.9921568627, green: 0.9882352941, blue: 0.9843137255, alpha: 1),
      secondary: #colorLiteral(
        red: 0.9921568627, green: 0.9882352941, blue: 0.9843137255, alpha: 1),
      highlight: #colorLiteral(
        red: 0.9921568627, green: 0.9882352941, blue: 0.9843137255, alpha: 1),
    )
  }

  public static var breakIdeasPrimary: Palette {
    Palette(
      primary: #colorLiteral(red: 0.8980392157, green: 0.5333333333, blue: 0.6392156863, alpha: 1),
      secondary: #colorLiteral(
        red: 0.8980392157, green: 0.5333333333, blue: 0.6392156863, alpha: 1),
      highlight: #colorLiteral(
        red: 0.8980392157, green: 0.5333333333, blue: 0.6392156863, alpha: 1),
    )
  }

  public static var breakIdeasAccent: Palette {
    Palette(
      primary: #colorLiteral(red: 0.9529411765, green: 0.8274509804, blue: 0, alpha: 1),
      secondary: #colorLiteral(red: 0.9529411765, green: 0.8274509804, blue: 0, alpha: 1),
      highlight: #colorLiteral(red: 0.9529411765, green: 0.8274509804, blue: 0, alpha: 1),
    )
  }
}
