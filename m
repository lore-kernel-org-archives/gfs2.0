Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063410949
	for <gfs2@lists.linux.dev>; Fri, 15 Sep 2023 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694786721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PpSIIB1mvYApP01E3iIGKXxZD7tQZq1zZDR9KGP+8mk=;
	b=KQOAUlOQc1jVk81cuUo0LZNM7s9tl8eYJ314ZTGPy2qXhr/XmGGj5ulWI9QIZ4hDPYtV7W
	wJq2zP7CTTrOl1ydZ/OUB6+7w7YlpjG2eikpfdT7geBeNV8aM1Zwy8T/O+8Sp8TzSfN7P5
	ujInfPQoRNznVkQe19za1wLhnN68yLI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-u8ZAMF1WPF6zqLaDhPT_qQ-1; Fri, 15 Sep 2023 10:05:19 -0400
X-MC-Unique: u8ZAMF1WPF6zqLaDhPT_qQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5218b9647a8so1486741a12.1
        for <gfs2@lists.linux.dev>; Fri, 15 Sep 2023 07:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694786718; x=1695391518;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PpSIIB1mvYApP01E3iIGKXxZD7tQZq1zZDR9KGP+8mk=;
        b=VjWR0JmmRNJyyruPnf+ckedLFbEpffPTbQ9+5RsHGuyIsV0b2UykkLEzijie/YhM4M
         jSBVK/BnQG3mLEFmYzZ/cPtFOiahLV67K4phc6IL+1FAbc9pxSFOnoBT1d53Gbs2Bfo/
         z15OpTkAogoL8S6vZWp3v6k9dIOS85VOZyu45i8Sq6B88o05u0G+EJZAU0P1xGiY9sEC
         dbWVwomEc1vKgiYiX3K9jKy7bAFvcnF7LFKd8mNpv9ZQGgpUuoRlh49x5UfUFHvwcaws
         tL95Uv3an/f5ApmGmyDd3C+2JKkDVv9hnJYcElpx7L3LB9RCcssXlS6DbQSaJZwTzSR5
         0kLg==
X-Gm-Message-State: AOJu0YyBDKqGCFrJHII1/IViKdZyCX5WgIQKryghA/1fZn4FPq6JCWNH
	nUoIsIOyS9TeiISOx8GMyrn8SBmw31AMDAf+WU4SubkYnB2iGE7UaPCuvg5s8Wo0z0F9uwN05HU
	7YegaNT5TohXctbBvbxy7k1HQQTCpUQ==
X-Received: by 2002:aa7:c24b:0:b0:522:1956:a291 with SMTP id y11-20020aa7c24b000000b005221956a291mr1403990edo.8.1694786718303;
        Fri, 15 Sep 2023 07:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENaUrSukINVFutVEhyltutN+3v2vUw89AHoLMRzYm50JTRklRonP/SpNHk7yTb23Zx0F5XJdth9ljX9cbq0VM=
X-Received: by 2002:aa7:c24b:0:b0:522:1956:a291 with SMTP id
 y11-20020aa7c24b000000b005221956a291mr1403978edo.8.1694786718009; Fri, 15 Sep
 2023 07:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 15 Sep 2023 10:05:06 -0400
Message-ID: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
Subject: nft_rhash_walk, rhashtable and resize event
To: Network Development <netdev@vger.kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@netfilter.org, fw@strlen.de, 
	gfs2@lists.linux.dev, David Teigland <teigland@redhat.com>, tgraf@suug.ch, 
	herbert@gondor.apana.org.au
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I try to find some ways that fits my use case of iterating a
rhashtable. I found [0] but it somehow tries to skip objects again if
a rhashtable resize event occurs during a hash walk. It does that by
skipping the already iterated objects according to a counter that is
tracked, see [0]:

if (iter->count < iter->skip)

from my understanding.

My question is here? Is that allowed to do because a resize event may
change the order how to iterate over a rhashtable.

Thanks.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/netfilter/nft_set_hash.c?h=v6.6-rc1#n257

