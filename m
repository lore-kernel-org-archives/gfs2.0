Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AEE5663
	for <gfs2@lists.linux.dev>; Fri, 13 Oct 2023 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwQ4KGmv"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40651a72807so18197505e9.1
        for <gfs2@lists.linux.dev>; Thu, 12 Oct 2023 23:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697178515; x=1697783315; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NybowjkklCXQYE6EaxfWBYfKXzUyBcBJ6MO4kBq1jlg=;
        b=cwQ4KGmvm5vW5dg7bx9bWeYbnJV+cFjFTSYGIpscLffEYIDhghOtmOiyo5pjUiYKKH
         RXfE8V6BOFggY64ejFXXIub1qL5zGci+IoamOhNH5Q0/NiIqOjS7Hc5vaSDZTM588TgQ
         MsCLyKpk7sWmgkrts4cV8vRd6x2EuEnGT/jr8xAoA6p6yJGL96fPI0m7w0VNm3h3qFzp
         y0Md2DyjpEud+GywOGDDA2aV+//QeVULKTib7Yb1/eOw2CQmxQcC2tbyQoVJD+I6gTKG
         B7ooZM1CTHwHZ5qcF7S5Uw6WcIdDtbO30jlHQc2DEnNEX7tIF3TWkM/JqR/ND5aKThq+
         V/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697178515; x=1697783315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NybowjkklCXQYE6EaxfWBYfKXzUyBcBJ6MO4kBq1jlg=;
        b=MrZEgbaSNBas3qqDt09i3MRDHevRCo6J5B9mBILtgn8IORKiidn6mxTRlEN7FBk4ad
         QtC1Ehh7WUS+/6R2XGjL8HA7BbqsFYQUEjmfyQR4/omZzAgbKLSEX82WXpYcQl/8JSer
         ofFoQr06VxSY4NNEut8mt6yUC7W7k11l19DHlY9yMe61dc5ajDOyIeb6vtjU/AabkPHT
         +WuW0unc+rDYaQlDF9izPoRxZWkPmVrdsDaWgesOeeeEn75zrhDberOHHJwyTBRdtTrI
         /9GAu9XbzNWe1o/lfuvW8TpNLZAGe4EoPZANau8M/scuPWCIdfmbcAfTXEdY7fJOjriI
         wxcw==
X-Gm-Message-State: AOJu0YzyBtbwYOIVATPa+Xxbn8ZDHOfHGCqbUoNHPH6m1flxYDLFmsDg
	URLaFV4+I6K7g5TPvpzzVCkz/lKyvyf2XsreW1E=
X-Google-Smtp-Source: AGHT+IEvH6+X8t6MVPA/kggWdUFeBhgmeltWl9gpQjvjVw+odhL/iUvkBIIemFcvqqUYsWBc+/dWXw==
X-Received: by 2002:a05:600c:214f:b0:405:4002:825a with SMTP id v15-20020a05600c214f00b004054002825amr22461248wml.13.1697178515017;
        Thu, 12 Oct 2023 23:28:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bcb88000000b0040646a708dasm1629910wmi.15.2023.10.12.23.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 23:28:34 -0700 (PDT)
Date: Fri, 13 Oct 2023 09:28:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: gfs2@lists.linux.dev
Subject: Re: [bug report] gfs2: Convert gfs2_jhead_process_page() to use a
 folio
Message-ID: <efb41d72-c254-46b6-8de5-dcd9d3ef8887@kadam.mountain>
References: <fb027038-46ee-49fa-be1f-28926e7e2387@moroto.mountain>
 <ZSgQe27OCfUpmsbS@casper.infradead.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSgQe27OCfUpmsbS@casper.infradead.org>

On Thu, Oct 12, 2023 at 04:27:55PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 12, 2023 at 12:43:34PM +0300, Dan Carpenter wrote:
> > Hello Matthew Wilcox (Oracle),
> > 
> > The patch 240159077d00: "gfs2: Convert gfs2_jhead_process_page() to
> > use a folio" from May 13, 2022 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> > 	fs/gfs2/lops.c:485 gfs2_jhead_process_page()
> > 	error: 'folio' dereferencing possible ERR_PTR()
> > 
> > fs/gfs2/lops.c
> >     469 static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
> >     470                                     struct gfs2_log_header_host *head,
> >     471                                     bool *done)
> >     472 {
> >     473         struct folio *folio;
> >     474 
> >     475         folio = filemap_get_folio(jd->jd_inode->i_mapping, index);
> > 
> > Does filemap_get_folio() need to be checked for errors?
> 
> In this specific case, we know that the folio is there and will always
> be returned.  See the comment on line 484.  Can I annotate this call so
> that the tool knows this is a special case and doesn't warn about it?
> 

Thanks for looking at this.  There is no annotation.  In the kernel we
are very good at fixing static checker warnings so everything old is a
false positive.

This one is from May but I recently changed how dereferences were
handled so it's the first time I had seen the warning.

regards,
dan carpenter

