Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0AF1DDE3
	for <gfs2@lists.linux.dev>; Thu, 21 Dec 2023 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/4hUsMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703162299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfOAS/Cfvy73NfYNUGoNrYx/8Pw3cjNZcgnpRXHhVXg=;
	b=Y/4hUsMVm09qwOBnvvT9v9i3SSjuIcPKm+CdF7fTrkVZpj324/9id1xef4Yg2VfLVp3QLv
	bO1Pww1ChsvyhQX/vBURd4/W/CcNVXcmAlaako5XII1788JKBK3ncQtC8LO9Hob6fNPD+4
	9C6Xw2re7VbazB/Vq/3ZFuts5L0D/WY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-cD6qNAQwO5mrENYcM5LK1g-1; Thu, 21 Dec 2023 07:38:17 -0500
X-MC-Unique: cD6qNAQwO5mrENYcM5LK1g-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d04dbb4811so7774855ad.0
        for <gfs2@lists.linux.dev>; Thu, 21 Dec 2023 04:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703162297; x=1703767097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfOAS/Cfvy73NfYNUGoNrYx/8Pw3cjNZcgnpRXHhVXg=;
        b=vac7JYEOrxjnJiOgIkNUbrt7MtsuraQ9JWfFqDNNLkxpAiCt9UB4hMyMnWMzfS6IqB
         XSZutzj4oPklgOCC+WtMke3LtoNMO9Fq1sKjHV56jjwpiFKaX4pTg7w83kVVKJnQujxs
         9N32r51YtNwrPYtOOzTOp8cVvPSwwXbPyBXiqTZ9vL2xo2H8aVjHWCYJ1aUOhw0tgul9
         cyrCkAlUQXTXkORABcYsdvl1xXmb13QvLsDLmP5AfpkIVDUomZEF7+f/lNWrMfdyFX6T
         2sc/pUiivwzTpQ1gwCtimK51CcWaaBF9BXmcwn1Xrorc6bg5oDcdG5Cpo/gs+o0fF0D5
         C7FQ==
X-Gm-Message-State: AOJu0YwpDUNIfjtP8GDAqTRLUPORl5WN4CvNo3O6RLfhCYeN/EBREYWd
	3XGbeJu/pPA6oKBc0qIzwqq7cpJOkUW/DhCLn3aQaBIM+DyhwR1rv45GBBpBo4PCXCAFrWoT0f7
	0zpnjJl9DdfYJolT6UCd/oDjzhnA2Cw==
X-Received: by 2002:a17:902:e54e:b0:1d0:b42f:e41b with SMTP id n14-20020a170902e54e00b001d0b42fe41bmr24446213plf.64.1703162296809;
        Thu, 21 Dec 2023 04:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcxmSGTi9Cen2vOZLOtaY1q0MkvT4Sc2+5Jcq+fjVEuZ63u18UmONPJhGdPt3NhdWBJzlbTeYFpqiaqcEO7EY=
X-Received: by 2002:a17:902:e54e:b0:1d0:b42f:e41b with SMTP id
 n14-20020a170902e54e00b001d0b42fe41bmr24446200plf.64.1703162296493; Thu, 21
 Dec 2023 04:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231206195807.764344-1-willy@infradead.org> <ZYMQx2070yb9Vkgs@casper.infradead.org>
In-Reply-To: <ZYMQx2070yb9Vkgs@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 21 Dec 2023 13:38:05 +0100
Message-ID: <CAHc6FU5Wn8NYn96SXyeWq5ifHnO9GChqcbDX5x2ebQaKKfvJYg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Remove use of error flag in journal reads
To: Matthew Wilcox <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 5:05=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Wed, Dec 06, 2023 at 07:58:06PM +0000, Matthew Wilcox (Oracle) wrote:
> > Conventionally we use the uptodate bit to signal whether a read
> > encountered an error or not.  Use folio_end_read() to set the uptodate
> > bit on success.  Also use filemap_set_wb_err() to communicate the errno
> > instead of the more heavy-weight mapping_set_error().
>
> Ping?

Pushed to for-next now. Thanks for the patch and reminder.

Andreas

