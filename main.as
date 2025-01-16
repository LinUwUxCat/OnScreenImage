array<Img> openImages;

int deleteNext = -1;

void RenderMenu(){
    if (UI::MenuItem(Icons::PlusCircle + " Add Image")){
        openImages.InsertLast(Img(""));
    }
    for (int i = 0; i < openImages.Length; i++){
        if (UI::MenuItem(Icons::FileImageO + " " + (openImages[i].isImg() ? openImages[i].imgName() : "New Image"))){
            deleteNext = i;
        }
    }

}

void Render(){
    for (int i = 0; i < openImages.Length; i++){
        if (!openImages[i].isImg()){
            // Idk
        } else {
            auto img = Images::CachedFromURL(openImages[i].url);
            if (img.m_texture !is null){
                nvg::BeginPath();
                nvg::Rect(openImages[i].pos, openImages[i].size);
                nvg::FillPaint(nvg::TexturePattern(UI::GetWindowPos(), UI::GetWindowSize(), 0.0f, img.m_texture, 1.0f));
                nvg::Fill();
                nvg::ClosePath();
            }
        }
    }
}

void RenderInterface(){
    for (int i = 0; i < openImages.Length; i++){
        if (UI::Begin(openImages[i].isImg() ? openImages[i].imgName() : "New Image", openImages[i].isOpen, UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::NoScrollbar)){
            // NEW IMAGE
            if (!openImages[i].isImg()){
                openImages[i].tempUrl = UI::InputText("Image URL", openImages[i].tempUrl);
                UI::SameLine();
                if (UI::Button("OK")){
                    openImages[i].url = openImages[i].tempUrl;
                    openImages[i].error = "";
                }
                if (openImages[i].error != "") UI::Text(openImages[i].error);
            } else { // Opened Image
                auto img = Images::CachedFromURL(openImages[i].url);
                if (img.m_texture !is null){
                    openImages[i].pos = UI::GetWindowPos();
                    openImages[i].size = UI::GetWindowSize();
                    UI::Text("Image Loaded, F3 hides this window btw");
                    if (UI::Button("Close Image")){
                        openImages[i].url = "";
                    }
                } else { // Image open error
                    UI::Text("Loading Image... If it doesn't work, press the button to cancel");
                    if (UI::Button("Cancel")){
                        openImages[i].url = "";
                    }
                }
            }

        }
        UI::End();
    }
}

void Update(){
    if (deleteNext != -1){
        openImages.RemoveAt(deleteNext);
        deleteNext = -1;
    }
}