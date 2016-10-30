class ImageMessage
  def output_message(context)
    {
        :type => "image",
        :originalContentUrl => choice_image,
        :previewImageUrl => choice_image
    }
end

def choice_image
    # images = [
    #     'https://pbs.twimg.com/media/B_QHDbSVEAA1adJ.jpg',
    #     'https://pbs.twimg.com/media/BuHSdwCCAAELvUK.jpg',
    #     'https://i.ytimg.com/vi/6nQyHeiDHu0/hqdefault.jpg',
    #     'https://s-media-cache-ak0.pinimg.com/564x/f2/a2/4f/f2a24f58f13823def4053e1ae32f2557.jpg',
    #     'https://pbs.twimg.com/media/CZQMsB-UYAQ-GJA.jpg',
    #     'https://ssl-stat.amebame.com/pub/content/8265872137/user/article/194267610976870743/ea20fa0d12335b8b2735d1a768d0932a/cached.jpg',
    #     'https://s-media-cache-ak0.pinimg.com/236x/f6/5c/8d/f65c8dfee01d6407e9e9cd8298cbeb5d.jpg',
    #     'https://pbs.twimg.com/media/CMTT-vPUAAErxqJ.png',
    #     'https://pbs.twimg.com/media/Bc7INKDCQAAp1d8.jpg',
    #     'https://pbs.twimg.com/media/B5RSK0pCYAA45il.png'
    # ]
    images = [
        'https://res.cloudinary.com/hmfnscv52/image/upload/v1477837218/kuehdcwcbdc49mfkpfij.png',
        'https://res.cloudinary.com/hmfnscv52/image/upload/v1477837251/it6rsnvr999htz0k4mwh.png',
        'https://res.cloudinary.com/hmfnscv52/image/upload/v1477837286/eutr6extozlex5gfpynt.png',
        'https://res.cloudinary.com/hmfnscv52/image/upload/v1477837316/cqv23xsye53hb8inlgz6.png'
    ]
    images.sample
end
end