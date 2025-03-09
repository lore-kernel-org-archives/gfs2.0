Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471B16B3B7
	for <gfs2@lists.linux.dev>; Sun,  9 Mar 2025 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557227; cv=none; b=MI/IaAKBhT2HHKWwLckSP1VsMKu/d+itGxGPYB+/4Vq9zfoa45DsKFGFOaEiDnlf1nJHahtNT4+qyLwbO3OrcqmWTj1jEcCv0HjFtdysQKtukC67x77o5O3L8p4v1OiUoqeTlEX+9FRz5TkXjKvQwbUXavDXA1JZLp1uOyfUpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557227; c=relaxed/simple;
	bh=Dfxxt+r0hXdbzrzqUEkehywoLzPDKnxD4DYdZYfs86Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3QZzz5at2MDdp5iwcCOwpsoXdXwjkm3PinK/w4BrnKkUQnqorx68apxgndxmzxMC6/q8d5iEJ2vp/Xc4jqprEvujPpadQOinQ1zigzKxFV8xwMmaZNSaRVLh3IwssyLK/Xe4zJ+th2hY+Crx5j2YyCYeBTrxHN1kYWF4UyeSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjinMXda; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjinMXda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741557224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D220kPRAxAKpv4Rtv81ljc15cpNzLUp1Nc2zaYhL/50=;
	b=TjinMXdaqGtqgwyJudxFhcLmfqFgEIV4PIeqOQodo+Qsx8ZNsygkkUvHuETZOe8AxDsKSg
	XutZfSPEAhH6shEHRoVvg20zM7WbXGSO7NJBtwRH0aKKQeeNI7SN7xc1LfaL00eUZL0tyJ
	k20kI/p242/SflJIrklGF3ykt8oIBPc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-9W_jn8J7NUGk_NHavCfTYg-1; Sun, 09 Mar 2025 17:53:42 -0400
X-MC-Unique: 9W_jn8J7NUGk_NHavCfTYg-1
X-Mimecast-MFC-AGG-ID: 9W_jn8J7NUGk_NHavCfTYg_1741557221
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22410053005so112301835ad.1
        for <gfs2@lists.linux.dev>; Sun, 09 Mar 2025 14:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557221; x=1742162021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D220kPRAxAKpv4Rtv81ljc15cpNzLUp1Nc2zaYhL/50=;
        b=Djkpye4OPn0tvEyFbMmimqRToVcsf/xhdJA4Wopmsbaxt4xOcu7yIgo4Mb8AGOXqg4
         xFGuo5Wfn9UWqQ+5tbhD3KAWQbbNlvctXLXKm2VdKebejXLze+03rK+uuBSVNwSX+9Yq
         0ORtZiu1IveiOyPmYwR1fco+8N20ykya9dlLQEK2xIZzESxgGHaCB1YNRaPBOlEwBles
         x1iqAMsOAS9JtLfrQIKXxqQ56OKGvnuihQuMvsdG6pQ1XHMHuGE3Y80Wz5T7mS5r1KXL
         Yqdxj0dwrdOwONXAdJ8xUDuFPwAxr9Ac8ZZkEQBnbnakp3Ze/8KCU2x7Db9cqPfd+NlX
         aiQw==
X-Gm-Message-State: AOJu0YwghOKRq+J1zyCPcskFykRyuamx8LP81dAgX7V+i01WSeMW2+8s
	K5PCGWV7hQOl07HXfzTb2meLFDdszFwKHJY3FkwyXMBYKMlf01LOu7e6O0xOzfWs+RDH9Abi20Z
	+o1kY3y0WYmXfsS4sO2KUeh8BMd5fNbh7zYRqppNU4iO1yIWK1lFSFbfZu48gy7OjF+ARxRs5U2
	iWHt9AFzMNb6GiJa8DjWHU4Z3ECg==
X-Gm-Gg: ASbGncuqipyIiNg5Zp6moAXK2p3D8lMeWpr+0Vb9x9I1nYOkVIy8GNrpmk0nBzWXK5f
	BJ7b0FWZ3DDm1K9CWGpcRkxOKfbG/E1ClTn34EavcH5R4XxCxqcnF4lNc+OVrjhEOSYzocwU=
X-Received: by 2002:a17:902:ce0a:b0:223:6436:72bf with SMTP id d9443c01a7336-22428bf7a47mr226700625ad.44.1741557221369;
        Sun, 09 Mar 2025 14:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy9eE/lJnK++FzwDyZZSQiP5YzqAdsEQu3UOj6KaHPde6EDa8B27QxjD2epfAPECN1Prg+sTjecJjnf3Rfl00=
X-Received: by 2002:a17:902:ce0a:b0:223:6436:72bf with SMTP id
 d9443c01a7336-22428bf7a47mr226700545ad.44.1741557221113; Sun, 09 Mar 2025
 14:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210133448.3796209-1-willy@infradead.org> <20250210133448.3796209-8-willy@infradead.org>
 <CAHc6FU5GrXSfxiRyrx_ShR7hJkCMaQD=k-mhTJ37CzbUMR68dQ@mail.gmail.com> <Z84Ay7gj2JQMUuRE@casper.infradead.org>
In-Reply-To: <Z84Ay7gj2JQMUuRE@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 9 Mar 2025 22:53:29 +0100
X-Gm-Features: AQ5f1JomwYAykhQyueBbfb5N9kGOjotRXW86-ojxbejCwBBL59wTO0IoKuKhxZ4
Message-ID: <CAHc6FU5TcVWAOH+Yu1Q0v2j363NXnm8cd2cA0_ug14MmdTtzqw@mail.gmail.com>
Subject: Re: [PATCH 7/8] gfs2: Convert gfs2_end_log_write_bh() to work on a folio
To: Matthew Wilcox <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CDcRL01pQQW-1tYmDnASnIKK8DOZpDTIWxdyfommj_E_1741557221
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 9:57=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
> On Sun, Mar 09, 2025 at 06:33:34PM +0100, Andreas Gruenbacher wrote:
> > On Mon, Feb 10, 2025 at 2:35=E2=80=AFPM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > > gfs2_end_log_write() has to handle bios which consist of both pages
> > > which belong to folios and pages which were allocated from a mempool =
and
> > > do not belong to a folio.  It would be cleaner to have separate endio
> > > handlers which handle each type, but it's not clear to me whether tha=
t's
> > > even possible.
> > >
> > > This patch is slightly forward-looking in that page_folio() cannot
> > > currently return NULL, but it will return NULL in the future for page=
s
> > > which do not belong to a folio.
> > >
> > > This was the last user of page_has_buffers(), so remove it.
> >
> > Right now in for-next, ocfs2 is still using page_has_buffers(), so I'm
> > going to skip this part.
>
> How odd.  I see it removed in 1b426db11ba8 ecee61651d8f 0fad0a824e5c
> 414ae0a44033 and all of those commits are in 6.14-rc1.
>
> $ git show v6.14-rc1:fs/ocfs2/aops.c |grep page_has
> (no output)

Hmm, you're right, it's only that automatic test that's based on an
older kernel. Sorry for the confusion.

Andreas

