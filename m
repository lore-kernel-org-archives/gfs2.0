Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77817498
	for <gfs2@lists.linux.dev>; Tue, 24 Oct 2023 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFgALvxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698146130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSJSEpKk86+44DHG1a6QAaN6xAMr6qX2sKIRljqSTyE=;
	b=BFgALvxQtTOlkPF+D70tHOvN/UIW9SrarUGlN2hNLH09vUbjRlnuDDYQxizRC4YptpHC4D
	AeCWwUCa+hOVivIpoiDK4JvGgQkcVNYo7G6y8R0ngKnBcswELYb9BaM1FpJsfjM1IlzmVk
	Y6kgpGiTV8Micsd13BrTcuMfdBpZwmE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-uFMtUyw3NeS2W_Ef7nbQRw-1; Tue, 24 Oct 2023 07:15:27 -0400
X-MC-Unique: uFMtUyw3NeS2W_Ef7nbQRw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c9cd87af72so47067805ad.1
        for <gfs2@lists.linux.dev>; Tue, 24 Oct 2023 04:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698146127; x=1698750927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSJSEpKk86+44DHG1a6QAaN6xAMr6qX2sKIRljqSTyE=;
        b=DSuSCyNToWKGzf0ThoB01TQdPThalEBqXcE1r33Yax787FU0OC6UoyjVxrSfh81MqD
         gA69fH0y/mZ0dVSHIx6uNEJkkZmd6kXxWjOCjMoNpLJbLMGRopeQoEDCfV0Vstecfn84
         rQ3UBQy0nd9287i5HxU7ZlWEi/9a53ASU2FYRgjytV/B+t5ghaCsudFO/VwMfhEJWlr4
         ueqyUjz7e7TH/B38SLnlIs4ufYSyHFOyqETIonQMjzUzpVJADFgiuDPhcUcEkgmqxUHB
         jZ2/v+01iJ+VtZLHxIW+e/LOo7iOtqXg2BD2St/Nh+aQmpZh3ze/sJ7V6/VHx8Ac2oG4
         Etjw==
X-Gm-Message-State: AOJu0YwgqLGMajN4NbHFJ5RGq/e7kjtXcxrYZ4ux/Iol/ENYori9vBT9
	F4y0vOgvnh+TtciTh9lanEbcRWLGox4/oL/VGqixKlXt4LQgDJlGZTvkgtEkHzPmhTpRCHQbmji
	Z0BywKp9Q3xkYRlty/uL+kkGVvOvJuw==
X-Received: by 2002:a17:903:2286:b0:1bd:da96:dc70 with SMTP id b6-20020a170903228600b001bdda96dc70mr12737215plh.49.1698146126999;
        Tue, 24 Oct 2023 04:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0L75G/Cj63Gt4JTm8S7BbzcPC+Dh8doYG/mYF2FW08Bb0r4vsCFa/ESAfWwBuQapL41pSj1XzYle4AshhNYw=
X-Received: by 2002:a17:903:2286:b0:1bd:da96:dc70 with SMTP id
 b6-20020a170903228600b001bdda96dc70mr12737199plh.49.1698146126743; Tue, 24
 Oct 2023 04:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231024075535.2994553-1-amir73il@gmail.com>
In-Reply-To: <20231024075535.2994553-1-amir73il@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 24 Oct 2023 13:15:14 +0200
Message-ID: <CAHc6FU700V+54hU+JPFYNDLkqicG=UPjU81N3UGmgiTSYnz3-g@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fs: derive f_fsid from s_uuid
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Bob Peterson <rpeterso@redhat.com>, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Amir,

On Tue, Oct 24, 2023 at 9:56=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> gfs2 already has optional persistent uuid.
>
> Use that uuid to report f_fsid in statfs(2), same as ext2/ext4/zonefs.

I've applied this patch, thank you.

Andreas

