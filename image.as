class Img {
    string url;
    string tempUrl; // Url when typing, before validating
    bool isOpen;
    string error;
    vec2 pos;
    vec2 size;

    Img(){
        this.url = "";
        this.isOpen = true;
        this.tempUrl = "";
        this.error = "";
        this.pos = vec2();
        this.size = vec2();
    }

    Img(string url){
        this.url = "";
        this.isOpen = true;
        this.tempUrl = url;
        this.error = "";
        this.pos = vec2();
        this.size = vec2();
    }

    bool isImg() {
        return this.url != "";
    }

    string imgName(){
        auto a = url.Split("/");
        return a[a.Length-1];
    }
}