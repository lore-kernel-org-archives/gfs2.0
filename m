Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7337F002
	for <gfs2@lists.linux.dev>; Thu, 23 Apr 2026 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776922506; cv=pass; b=kKPrM2R3H8nIMIm+fRSsf7SJBaJDE8zTHMD6hMiQBXUc+ow+qIqtCQUHepnVFXAlmkKTgsdyRb7MnxucfMOzb9UiTsXgnYgJpPU/5/2YaOg8WMukpUDHv3cNZF3lDwZZXXJkenAUvu13Ds20ybZQ373CwjsQs5zoQU1yhGzRD7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776922506; c=relaxed/simple;
	bh=nlovYeV1hp2rTBH4voPl8L4aUf+dnj2AJsurzi7qv1c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=vCNjAooAXMtiprChQ2VBKAYTy/RMnHAfyz1PP/8ZXpOYUocBzVZv6FXXY3GYytM2sGSFIQI6JhN8ipEufIWGJTTY4/flzEYdGEurZ0pfDzGqYmUBu1HHhUxXwiMXuSUPlLAKo5xF1bZ7WBfeF7LKq4UU/KeAWeoAEqgRWIrvx5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFaf3TfW; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFaf3TfW"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7991db3dc98so69106807b3.0
        for <gfs2@lists.linux.dev>; Wed, 22 Apr 2026 22:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776922504; cv=none;
        d=google.com; s=arc-20240605;
        b=NCQcBRcW5ULQx43mx/qIdph0dxpbvh0/35/ekxHVMvGKVXDxSSpPJIKpiMZ86mb4cY
         VlCmi2qDA0Bs22Xe0PoFjq5ARJKrxipUq0EoX40sxTC/R6/zo7BrIYk0TXQlQoWMzros
         R9Mj8cGALCY/Lqs2ltXLEuBa5BmTsvi6QpEv5/y3n5BMosbIfrIlgpuRM9Vcvz8kIhvt
         h1gCbUjrukk6t79KlUxiErpJThSqlK7KedE11GeTbFnDG22HgfDxwYqqXx2xnBBux6RQ
         9C5tnWq2WpkvTr4KUVPlcHxHTEWHPWQAhdM0Gs+cjFqru98nbqkaIH34HZlYwCiwjw9I
         6QdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=wHFYFFLNnFneINlGhMongHRhlLkwjKQT0tklhJvyskk=;
        fh=JXPem03tfFl/MdxcNFT0iYtbxBTgthb4mcn2KjA+wWk=;
        b=jEzyzFJuyDKBcyKOPa+aJ7IslDDgau6NX37T6qz40j9OvJuxWN4OlI38medPs5NTS7
         JN+4BQD1oRLW+UHhLrTJufEq47yDM+Yk8bx3WRVj1kNTsv9E2Dcq+1RKgm6Xoeg2oWFa
         bAP4CgqQ8we07IqVvWeGpBTy1XaCfaskzz3ULmSy5lCcIqDq3cLprx4CxR8gNLXN6Ebn
         9YM/7Y8LHm51+upXNCa+FeeUzFF5ZoR5hWfMRIFekgWiNxIDOxaT7e2nGjlkwnxyaEzo
         dUQdMZTAR5THDp+Po+sl85xJIwnN9Mo8PlHMk2r9/N+KUBHi0dodkTXDL9T1AdBzSK9C
         qklA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776922504; x=1777527304; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wHFYFFLNnFneINlGhMongHRhlLkwjKQT0tklhJvyskk=;
        b=PFaf3TfWACCou6u87pKdoi1IJQ18i5MVWYDyjX6o1a0BJqvtXc/iA5GKire+YbRtkI
         qfkf9ltGD6rYiiYIHS2M/JdACmunXJdW2/yt4Z2saDwOiI8kW41xqlsTqCwiomLjiNVK
         jtjF61yShKm5h4QipisoaIaGdsI4ERCbpGoybtN2xsuSoxbJzVUonKHiPP2P5EkEuA1k
         DOHFwUwVNkHASNG2nFQTiFsseJ6Ym1vpQpdYEvGqqkjkUFG7WACn1svFAI0h9JFR1Jz6
         xKW3jpK9Spw5d0CwhAbpb6CKJJ78CiJl5ANwxnpnoiCVN7RbwnwZ2FET4VYAlbieUw4N
         qrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776922504; x=1777527304;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHFYFFLNnFneINlGhMongHRhlLkwjKQT0tklhJvyskk=;
        b=Hxf4IhHGY4ViryXG5ikDk8w1EsKLA9/73obQz/yvRVuy9J+802LhMlYvcZzxDEgqPL
         bJJadMlCmiiPy0suY8EvaILXv02w9iuAXAi0Fcsn33tJ8CWHGLUCG5XGiALgKXQu4MEi
         dPfN2gj3fXzGzQLfZ/2KgSuFPnWjH1kwArzxxKtL1EBkIp35lJPoOX4zh09gt6SnD7T9
         Y6qq6iqxwIY8V8NyePgfw0b/RZ+soTHbHEdUd3lKDlzr7UnIxhSZvr7ol2rodSO5SZud
         6qbdMtflD8CRTzMAEpX6k8yMEfuMQ0QEGmmFdcKpEBFiEUo582lf+6tZHgwlJhKu0dHk
         9nJg==
X-Gm-Message-State: AOJu0YxRpdSBTsU1VJ0HdXuUTghf9cr0KBXX4rimec5g+UaBwIynkH68
	+HfGZp3Fhznb5T3Lz1GpiPbd7oWLFa1VWJxX8Ol+ZQYj4WBYYekhWSKKY9TJkxG1cWxzKV/dz9k
	1e3zZAaN8Twey+02YvWaPFBiIAB+AWpA=
X-Gm-Gg: AeBDieumE2Q7zmgPLv+DkZ4GfRbcitNoBPdzCfmLvsY58ZAZzNO3DuBE3nMe+JEOCzi
	dEavd/52u7ucwelttVHbD5RWiyiyG79t53RuEdg0XuIFtW0nC9qfOFtyWwNxVL4XlhGQI9bnsaL
	T2esJyzuenCVDGdmGruhtPst5wJTs+JNuBb4ySsOjgzCbUwSypRsDvjwtjQWE2MoT8N5bRIgpmk
	dG5TG80h8OthsPFFFiF8u5TYIwkoygTEDDPRCk6wm5fiH3miLiF9yrrq4YvGG2w2ISuCs8ktxWT
	G62OMWDqUcZZU27ZrzH8
X-Received: by 2002:a05:690c:4992:b0:7b3:edc7:9b8f with SMTP id
 00721157ae682-7b9eccec11amr260553967b3.0.1776922504466; Wed, 22 Apr 2026
 22:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Thu, 23 Apr 2026 13:34:52 +0800
X-Gm-Features: AQROBzBaqQqFQaWabV6inclLIjBjcfbJjkonKQq4T5Mn_5OXxBX-QVbo4gp6yBc
Message-ID: <CAGp+u1ZE7UsQ4sSUHBKQXU8x3M_jwK=ek1urSjEtd3jXQGFmVg@mail.gmail.com>
Subject: [bug report] Potential order violation in fs/dlm/midcomms.c, between
 'dlm_midcomms_addr()' and 'dlm_midcomms_exit()'
To: aahringo@redhat.com, teigland@redhat.com
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel maintainers,

My research-based static analyzer found a potential atomicity bug
within the 'fs/dlm' subsystem, more specifically, in
'fs/dlm/midcomms.c'.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
dlm_midcomms_addr
    --> node = kmalloc(sizeof(*node))
    --> hlist_add_head_rcu(&node->hlist, &node_hash[r]); [t0]
    --> node->debugfs = dlm_create_debug_comms_file(nodeid, node); [t3]

T1:
dlm_midcomms_exit
   --> hlist_for_each_entry_rcu(node, &node_hash[i], hlist) [t1]
   --> dlm_delete_debug_comms_file(node->debugfs); [t2]

In T0, the freshly allocated midcomms_node is first added to the
globally visible 'node_hash' list, and then has its 'debugfs' field
set up.
In this case, in T1, the exit function can first iterate over the
'node_hash' list and access a 'debugfs' field that has not been set up
yet.
The concurrent buggy order is t0 -> t1 -> t2 -> t3, causing order violation.

Please kindly check at your convenience. Thank you for your time and
consideration.

Best regards,
Ginger
