Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE142C0F6F
	for <gfs2@lists.linux.dev>; Tue,  3 Feb 2026 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118993; cv=none; b=sPJC5Be3QxRSyk2qH+1XpqPuB4oU9hAeBjxM9OJjVeulX/7It1YnIoZn7gWinp92teQAXFwtmXYqk7vchTVfwrRvtX+mFhfTQi+1tiYcMMlUveZfTeJZvNCEWjikVS3tg5J3iZEuco1AknUfM60z4yJKO4MC9Y2YKkeahsZrTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118993; c=relaxed/simple;
	bh=5+Eg/GSUM5PlilOUyyBYJl0Z9wyueL6j7TVADyqgoWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVwWH+ef6qp02zk1lgzGQEbRbsMwxrfb3cEeBLHzC04vbp6tIgINDPinM9WRsrz3cw89TlwvUBAUriu9BvHgLBHJ0HssQUStz15nptKWZnnAfWp04To9xN+GtqIDpKWyDvBnVe3lVmCO1+WMBOymbWuWxnTP2cNNdR7FGfHdPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOZbxZYT; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOZbxZYT"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6495d592c10so4926552d50.1
        for <gfs2@lists.linux.dev>; Tue, 03 Feb 2026 03:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770118991; x=1770723791; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hGI5B0B/7uJqpu0kk2emLXKb3dGWeAAqf071Km/wBI=;
        b=XOZbxZYTIptEjJEcxzZymwsnGuKeGsMCfUyM1mkd6nmgw2foyoKoKctBF3GgCqKHBa
         2f8ENvqTTFhJ6SkN2GyJ9LVoL3IYhtPujWgI9lQ+KQcEbS5vrKyLM6mJAClGJEc61CO1
         tuKHVgpDbE6CuVJ5gWcWSU84wSz+tn9hskgVoiouKW5cpS7tA2BCBWEKIu3/ftzPDzF4
         h1Tz2NXi5g9UJnHwLFg65WyxKQJuseWCQsua3WM0rduhTOdJoWSuCDwQGLjBv74hLf/X
         OyWn7OkWPpN92nTAOrw0YHRiezlaSD4ApR81doPJYiab0fxtr8T5Dao1myd5pCX4CnbC
         AadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770118991; x=1770723791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/hGI5B0B/7uJqpu0kk2emLXKb3dGWeAAqf071Km/wBI=;
        b=Gw8a0FBWTSWabosDhUXhfLvjd9M2UzCwAnJs5FAkSqZ49KYKR0d0tEsp4QxkR0nsDg
         GGUsmHZluWd3ZH8uIKtvvaVYDFvi4GWRtc62RMbhq6qGSrQVBnHM8csZoPD69QTTafqg
         4NnH7A5rVzYIvK8nQhp9nHIKx+4+t5uXExO9C0iOpSPtuscJotsgdracO/tQbPXZX+n3
         uIOH2g2JrFhzo15/I5H1qCCKxakBUXheOWfrG3y7XE+O42h1gcYwKRY5DDCHABqGMmG1
         /jNHPGHArsi5H3ZWzL+6Lg0ze9110SWr2i98f9lysCTgC+eEQ8hpc+I83Islb6pZqFjl
         j/Xw==
X-Gm-Message-State: AOJu0YzKqjOvPr1Ldy8prqF0P/SCO0XD/IQhkR2QM22CNrl9crFY+cxi
	1OYsKlBmGZBxA5JYGP3mrS8lhYkSB4ILqEuSHSoD8ucwGsx9PRGAp/PL
X-Gm-Gg: AZuq6aJPGFXmNAGsdvRcqooMTYcz+pds2+rw5SgIn4hn1igAAms3BfAR8ySqzQGB2PX
	6L1dQr0zWGcf10tZeN4+jCv+8ijNb3yPED0ih6L0WwkQ9z4+bbfhI10Oq5dlfAIf5GrCI5PRco0
	1GKI1r1jdKtkk50YJqnW0wPLTzlHOm4V5TyySLrqhJmmEuyyA3igQyR1FJ5PpWpLtnfPW8FkMS5
	8BkcaMP/UkUYBbWC+5gzBuPcAIWhdSzwDSkVZ9bIfv9Xoj2WIPJHnUB8Jty5BQYYLwpslA/oYAH
	guP71LBHga7USTs1W5rs3dbo7htlkeHk6MEgpp96/1pdVlWlb3hxZIskAiNZPOUwSTfRW8qTJHF
	F6DenyyWcMoQSBzckJXCrB15XcBLypH20XNT17GpcGLo8x70rxwzfWShSKHEzeJsrnwGpYjGvYp
	0RQrzZ/IHA7g==
X-Received: by 2002:a05:690e:168f:b0:646:6f6f:65e with SMTP id 956f58d0204a3-649a83cc03dmr11957134d50.24.1770118990906;
        Tue, 03 Feb 2026 03:43:10 -0800 (PST)
Received: from fedora ([187.120.156.78])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649960efc6esm11690333d50.17.2026.02.03.03.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 03:43:10 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	trintaeoitogc@gmail.com
Subject: Re: [RESEND PATCH] gfs2: do not evict glocks with populated address spaces
Date: Tue,  3 Feb 2026 08:42:57 -0300
Message-ID: <20260203114257.25469-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAHc6FU7kH3VfyERRTFuCshiSq0c-ttJLG7OeX_j31K9ehvH7uQ@mail.gmail.com>
References: <CAHc6FU7kH3VfyERRTFuCshiSq0c-ttJLG7OeX_j31K9ehvH7uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > Metadata glocks may have associated address spaces used as caches. Avoid
> > reclaiming such glocks under memory pressure while their mappings are
> > still populated or their state is not unlocked, as this can lead to
> > invalid page cache state and GLOCK_BUG_ON().
> 
> What invalid page cache state and GLOCK_BUG_ON() errors is this about, exactly?
On __gfs2_glock_put() (fs/gfs2/glock.c) the GLOCK_BUG_ON() is triggered under
memory pressure while the glock is still locked or the glock is populated with
metadata caches.

This happens because the __gfs2_glock_put() can't truncate pages with a private
datas (truncate_inode_pages_final(mapping) is failed), how the metadata is a
private folio, the	GLOCK_BUG_ON(gl, !mapping_empty(mapping)) is trigged.

> This leaks a glock reference, so it's definitely wrong.
But this glock is a private folio with metadata or is still locked. I think
this can't be evictable 
